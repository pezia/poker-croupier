
class Croupier::Player

  attr_reader :name
  attr_reader :stack

  def initialize(strategy)
    @strategy = strategy
    @name = strategy.name
    @stack = 1000
  end

  def competitor_status(player)
    competitor = API::Competitor.new
    competitor.name = player.name
    competitor.stack = player.stack

    @strategy.competitor_status competitor
  end
end