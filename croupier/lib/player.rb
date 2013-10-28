class Croupier::Player
  attr_reader :stack

  def initialize(strategy)
    @strategy = strategy
    @stack = 1000
    @active = true
    @forced_bet = nil
  end

  def withdraw(bet)
    @stack -= bet
  end

  def active?
    @active
  end

  def fold
    @active = false
  end

  def force_bet bet
    @forced_bet = bet
  end

  def bet_request
    bet = @forced_bet || @strategy.bet_request
    @forced_bet = nil
    bet
  end

  def method_missing(method, *args)
    @strategy.send(method, *args)
  end
end