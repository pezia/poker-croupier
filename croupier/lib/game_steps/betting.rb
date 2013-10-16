class Croupier::GameSteps::Betting
  def run(game_state)
    game_state.players.each do |_|
      game_state.transfer_bet game_state.player_in_action, game_state.player_in_action.bet_request, :raise
      game_state.next_player
    end
  end
end
