class Croupier::Player
  attr_reader :stack

  def initialize(strategy)
    @strategy = strategy
    @stack = 1000
    @active = true
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

  def method_missing(method, *args)
    @strategy.send(method, *args)
  end
end