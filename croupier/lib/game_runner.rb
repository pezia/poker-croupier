
class Croupier::GameRunner

  include Croupier::GameSteps
  GAME_STEPS = [
      IntroducePlayers,
      ShuffleCards,
      DealHoleCards,
      PreFlopBettingStep,
      DealFlop,
      Betting::Step,
      DealTurnCard,
      Betting::Step,
      DealRiverCard,
      Betting::Step,
      Showdown
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
    while @game_state.players_in_game.length >= 2 do
      GAME_STEPS.each do |step_type|
        step_type.new(@game_state).run
      end
      @game_state.next_round!
      sleep 5
    end
  end

  def small_blind
    @game_state.small_blind
  end

  def big_blind
    @game_state.big_blind
  end
end
