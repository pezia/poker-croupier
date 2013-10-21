class Croupier::GameSteps::Betting
  def run(game_state)
    @game_state = game_state

    run_with_state
    @game_state = nil
  end

  private

  def run_with_state
    @total_player_bets = Array.new(@game_state.players.length, 0)
    @last_raise = 0
    @current_buy_in = 0

    @game_state.players.each_index do |in_action|
      handle_player in_action
    end

    in_action = 0
    until betting_is_over? in_action
      handle_player in_action
      in_action = (in_action + 1) % (@game_state.players.length)
    end
  end

  def betting_is_over?(in_action)
    @last_raise == in_action
  end

  def handle_player(in_action)
    bet = @game_state.players[in_action].bet_request

    @total_player_bets[in_action] += bet

    if @total_player_bets[in_action] > @current_buy_in
      @current_buy_in = @total_player_bets[in_action]
      @last_raise = in_action
    end

    @game_state.transfer_bet @game_state.players[in_action], bet, :raise
  end
end
