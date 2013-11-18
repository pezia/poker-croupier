class Croupier::GameSteps::Betting::Player

  def initialize(betting_state, index)
    @betting_state, @index = betting_state, index
    @player = betting_state.players[index]

    @player.total_bet = 0
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
    @betting_state.transfer_bet @player, @player.stack, :allin
    @player.allin
    update_minimum_raise @player.stack
  end

  def call_bet?(bet)
    @player.total_bet + bet >= @betting_state.current_buy_in
  end

  def handle_call
    bet_type = (@betting_state.current_buy_in == 0) ? :check : :call
    @betting_state.transfer_bet @player, to_call, bet_type
  end

  def to_call
    @betting_state.current_buy_in - @player.total_bet
  end

  def raise_bet?(bet)
    raise_by(bet) >= @betting_state.minimum_raise
  end

  def raise_by(bet)
    @player.total_bet + bet - @betting_state.current_buy_in
  end

  def handle_raise(bet)
    @betting_state.transfer_bet @player, bet, :raise
    @betting_state.current_buy_in = @player.total_bet
    @betting_state.last_raise = @index
    update_minimum_raise bet
  end

  def update_minimum_raise(bet)
    @betting_state.minimum_raise = [@betting_state.minimum_raise, raise_by(bet)].max
  end

  def handle_fold
    @betting_state.transfer_bet @player, 0, :fold
    @player.fold
  end
end