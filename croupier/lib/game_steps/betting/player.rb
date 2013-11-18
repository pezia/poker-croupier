class Croupier::GameSteps::Betting::Player

  def initialize(betting_state, index)
    @betting_state, @index = betting_state, index
    @player = betting_state.players[index]
  end

  def take_turn
    unless @player.active?
      return
    end

    bet = @player.bet_request

    if allin_bet?(bet)
      handle_allin
    elsif raise_bet?(bet)
      handle_raise bet
    elsif check_bet?(bet)
      handle_check
    elsif call_bet?(bet)
      handle_call
    else
      handle_fold
    end
  end

  def active?
    @player.active?
  end

  def allin?
    @player.allin?
  end

  def total_bet
    @player.total_bet
  end

  private


  def allin_bet?(bet)
    bet >= @player.stack
  end

  def handle_allin
    handle_bet @player.stack, :allin
  end

  def raise_bet?(bet)
    raise_by(bet) >= @betting_state.minimum_raise
  end

  def handle_raise(bet)
    handle_bet bet, :raise
  end

  def check_bet?(bet)
    bet == 0 && @betting_state.current_buy_in == 0
  end

  def handle_check
    handle_bet to_call, :check
  end

  def call_bet?(bet)
    @player.total_bet + bet >= @betting_state.current_buy_in
  end

  def handle_call
    handle_bet to_call, :call
  end

  def to_call
    @betting_state.current_buy_in - @player.total_bet
  end

  def handle_fold
    handle_bet 0, :fold
    @player.fold
  end

  def handle_bet(bet, type)
    update_minimum_raise bet
    @betting_state.transfer_bet @player, bet, type
    update_current_buy_in_and_mark_last_raise
  end

  def update_minimum_raise(bet)
    @betting_state.minimum_raise = [@betting_state.minimum_raise, raise_by(bet)].max
  end

  def raise_by(bet)
    @player.total_bet + bet - @betting_state.current_buy_in
  end

  def update_current_buy_in_and_mark_last_raise
    if @betting_state.current_buy_in < @player.total_bet
      @betting_state.current_buy_in = @player.total_bet
      @betting_state.last_raise = @index
    end
  end
end