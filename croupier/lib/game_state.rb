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
    @player_on_first_position = 0
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

  def first_player
    @players[0]
  end

  def second_player
    @players[1]
  end

  def third_player
    @players[2]
  end

  def transfer(player, amount)
    player.stack -= amount
    @pot += amount
  end
end
