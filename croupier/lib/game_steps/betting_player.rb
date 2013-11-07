class Croupier::GameSteps::BettingPlayer

  def initialize(game_state, index)
    @game_state, @index = game_state, index
    @player = game_state.game_state.players[index]

    @total_bet = 0
  end

  def take_turn
    unless @player.active?
      return
    end

    bet = @player.bet_request

    @total_bet += bet

    if raise?
      handle_raise bet
    elsif call?
      handle_call bet
    else
      handle_fold
    end
  end

  private

  def call?
    @total_bet == @game_state.current_buy_in
  end

  def handle_call(bet)
    bet_type = (@game_state.current_buy_in == 0) ? :check : :call
    @game_state.game_state.transfer_bet @player, bet, bet_type
  end

  def raise?
    @total_bet > @game_state.current_buy_in
  end

  def handle_raise(bet)
    @game_state.current_buy_in = @total_bet
    @game_state.last_raise = @index
    @game_state.game_state.transfer_bet @player, bet, :raise
  end

  def handle_fold
    @game_state.game_state.transfer_bet @player, 0, :fold
    @player.fold
  end
end