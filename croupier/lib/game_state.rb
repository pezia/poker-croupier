class Croupier::GameState
  attr_reader :players
  attr_reader :small_blind
  attr_reader :big_blind

  def initialize
    @players = []
    @small_blind = 10
    @big_blind = 20
  end

  def register_player(player)
    @players << player
  end

  def deck
    @deck ||= Croupier::Deck.new
  end
end