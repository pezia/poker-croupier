class Croupier::GameState
  attr_reader :players
  attr_reader :spectators
  attr_reader :small_blind
  attr_reader :big_blind
  attr_reader :pot

  attr_accessor :community_cards

  def initialize
    @players = []
    @spectators = []
    @small_blind = 10
    @big_blind = 20
    @pot = 0
    @current_player = 0
    @dealers_position = 0
    @community_cards = []
  end

  def register_player(player)
    @players << player
  end

  def register_spectator(spectator)
    @spectators << spectator
  end

  def deck
    @deck ||= Croupier::Deck.new
  end

  def each_observer
    (@players + @spectators).each do |observer|
      yield observer
    end
  end

  def each_spectator
    @spectators.each do |observer|
      yield observer
    end
  end

  def each_player
    @players.each do |observer|
      yield observer
    end
  end

  def transfer_bet(player, amount, bet_type)
    player.total_bet += amount
    transfer player, amount
    each_observer do |observer|
      observer.bet player, amount: amount, type: bet_type
    end
  end

  def transfer(player, amount)
    player.stack -= amount
    @pot += amount
  end

  def dealer
    @players[dealers_position]
  end

  def first_player
    @players[nthPlayer 1]
  end

  def second_player
    @players[nthPlayer 2]
  end

  def players_in_game
    @players.select { |player| player.has_stack? }
  end

  def next_round!
    @players.each do |player|
      player.initialize_round
    end

    move_deal_button_to_next_player

    if orbit_completed
      double_the_blinds
    end
  end

  private

  def orbit_completed
    @dealers_position == 0
  end

  def double_the_blinds
    @small_blind *= 2
    @big_blind *= 2
  end

  def move_deal_button_to_next_player
    @dealers_position = nthPlayer 1
  end

  def nthPlayer(n)
    (@dealers_position + n) % players.count
  end
end
