class Croupier::GameSteps::PostBlinds
  def run(game_state)
    game_state.transfer_bet game_state.players[0], game_state.small_blind, :blind
    game_state.transfer_bet game_state.players[1], game_state.big_blind, :blind
  end
end
