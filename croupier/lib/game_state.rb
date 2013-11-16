class Croupier::GameState
  attr_reader :players
  attr_reader :spectators
  attr_reader :small_blind
  attr_reader :big_blind
  attr_reader :pot

  attr_accessor :community_cards
  attr_accessor :dealers_position

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
    first_player_index = (dealers_position + 1) % players.count;
    @players[first_player_index]
  end

  def second_player
    second_player_index = (dealers_position + 2) % players.count;
    @players[second_player_index]
  end

  def players_in_game
    @players.select { |player| player.has_stack? }
  end

  def next_round!
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
    @dealers_position = players.index(first_player)
  end

end
