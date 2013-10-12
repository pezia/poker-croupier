
class Croupier::GameRunner

  include Croupier::GameSteps
  GAME_STEPS = [IntroducePlayers.new, ShuffleCards.new, PostBlinds.new, DealHoleCards.new]

  def initialize
    @game_state = Croupier::GameState.new
  end

  def register_player(player)
    @game_state.register_player player
  end

  def start_sit_and_go
    GAME_STEPS.each do |step_type|
      step_type.run(@game_state)
    end
  end

  def small_blind
    @game_state.small_blind
  end

  def big_blind
    @game_state.big_blind
  end
end