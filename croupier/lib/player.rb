
class Croupier::Player

  attr_reader :stack

  def initialize(strategy, transport)
    @strategy = strategy
    @transport = transport
    @stack = 1000
  end

  def open
    @transport.open
  end

  def close
    @transport.close
  end

  def competitor_status(player)
    competitor = API::Competitor.new
    competitor.name = player.name
    competitor.stack = player.stack

    @strategy.competitor_status competitor
  end

  def name
    @name ||= @strategy.name
  end

  def hole_card(value, suit)
    card = API::Card.new
    card.value = value
    card.suit = API::Suit.const_get(suit.to_sym)

    @strategy.hole_card(card)
  end
end