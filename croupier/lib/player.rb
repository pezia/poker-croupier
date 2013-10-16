require 'player_strategy'

class Croupier::Player < Croupier::ThriftObserver

  attr_reader :stack

  def initialize(strategy, transport)
    super(strategy, transport)
    @stack = 1000
  end

  def hole_card(card)
    strategy.hole_card(gateway[card])
  end

  def withdraw(bet)
    @stack -= bet
  end
end