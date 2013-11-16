class Croupier::GameState
  attr_reader :players
  attr_reader :spectators
  attr_reader :small_blind
  attr_reader :big_blind
  attr_reader :pot

  attr_accessor :community_cards
  attr_accessor :player_on_first_position

  def initialize
    @players = []
    @spectators = []
    @small_blind = 10
    @big_blind = 20
    @pot = 0
    @current_player = 0
    @player_on_first_position = 0 # she has the dealer button
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

  def first_player
    @players[player_on_first_position]
  end

  def second_player
    second_player_index = (player_on_first_position + 1) % players.count;
    @players[second_player_index]
  end

  def third_player
    third_player_index = (player_on_first_position + 2) % players.count;
    @players[third_player_index]
  end

  def players_has_stack
    @players.select { |player| player.has_stack? }
  end

  def next_round!
    # give the dealer button to the next player
    @player_on_first_position = players.index(second_player)
  end

end
