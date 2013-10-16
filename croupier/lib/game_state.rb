class Croupier::GameState
  attr_reader :players
  attr_reader :spectators
  attr_reader :small_blind
  attr_reader :big_blind
  attr_reader :pot

  def initialize
    @players = []
    @spectators = []
    @small_blind = 10
    @big_blind = 20
    @pot = 0
    @current_player = 0
    @player_on_first_position = 0
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

  def each_player_and_spectator
    (@players + @spectators).each do |observer|
      yield observer
    end
  end

  def each_spectator
    @spectators.each do |observer|
      yield observer
    end
  end

  def transfer_bet(player, amount, bet_type)
    transfer player, amount
    each_player_and_spectator do |observer|
      observer.bet player, amount: amount, type: bet_type
    end
  end

  def transfer_prize(player, amount)
    transfer player, -amount
  end

  def player_in_action
    players[@current_player]
  end

  def next_player
    @current_player = (@current_player + 1) % @players.length
  end

  def reset_to_first_position
    @current_player = @player_on_first_position
  end

  private

  def transfer(player, amount)
    player.withdraw amount
    @pot += amount
  end
end