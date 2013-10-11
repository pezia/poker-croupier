class Croupier::GameState
  attr_reader :players

  def initialize
    @players = []
  end

  def register_player(player)
    @players << player
  end
end