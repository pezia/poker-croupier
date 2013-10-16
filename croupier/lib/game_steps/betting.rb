class Croupier::GameSteps::Betting
  def run(game_state)
    game_state.transfer_bet game_state.players[0], game_state.players[0].bet_request, :raise
  end
end
