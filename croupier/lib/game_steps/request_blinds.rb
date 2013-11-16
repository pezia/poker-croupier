class Croupier::GameSteps::RequestBlinds < Croupier::GameSteps::Base

  def run
    @game_state.second_player.force_bet @game_state.small_blind
    @game_state.third_player.force_bet @game_state.big_blind
  end
end
