
class Croupier::Player

  attr_reader :name
  attr_reader :stack

  def initialize strategy
    @strategy = strategy
    @name = strategy.name
    @stack = 1000
  end

  def competitor_status status
    @strategy.competitor_status status
  end
end