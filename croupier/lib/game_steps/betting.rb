class Croupier::GameSteps::Betting
  def run(game_state)
    @game_state = game_state
    run_with_state
    @game_state = nil
  end

  def run_with_state
    handle_player_in_action
    if @game_state.players.length > 1
      handle_player_in_action
    end
  end

  def handle_player_in_action()
    bet = @game_state.player_in_action.bet_request
    @game_state.transfer_bet @game_state.player_in_action, bet, :raise
    @game_state.next_player
  end
end
