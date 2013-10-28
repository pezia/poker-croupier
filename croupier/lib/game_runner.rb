
class Croupier::GameRunner

  include Croupier::GameSteps
  GAME_STEPS = [
      IntroducePlayers,
      ShuffleCards,
      DealHoleCards,
      RequestBlinds,
      Betting,
      Flop
  ]

  def initialize
    @game_state = Croupier::GameState.new
  end

  def register_player(player)
    @game_state.register_player player
  end

  def register_spectator(spectator)
    @game_state.register_spectator spectator
  end

  def start_sit_and_go
    GAME_STEPS.each do |step_type|
      step_type.new(@game_state).run
    end
  end

  def small_blind
    @game_state.small_blind
  end

  def big_blind
    @game_state.big_blind
  end
end