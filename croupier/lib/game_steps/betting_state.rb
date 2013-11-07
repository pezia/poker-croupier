class Croupier::GameSteps::BettingState
  attr_accessor :last_raise
  attr_accessor :current_buy_in
  attr_reader :game_state

  def initialize(game_state)
    @game_state = game_state
    @current_buy_in = 0
    @last_raise = 0
  end
end