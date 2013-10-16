class SpecHelper::FakePlayer < SpecHelper::DummyClass
  attr_accessor :stack

  def initialize
    @stack = 1000
  end

  def withdraw(bet)
    @stack -= bet
  end
end