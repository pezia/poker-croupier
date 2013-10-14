class Croupier::Spectator

  attr_accessor :stack

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

  def competitor_status(competitor)
    api_competitor = API::Competitor.new
    api_competitor.name = competitor.name
    api_competitor.stack = competitor.stack

    @strategy.competitor_status api_competitor
  end

  def name
    @name ||= @strategy.name
  end

  def hole_card(competitor, card)
    api_competitor = API::Competitor.new
    api_competitor.name = competitor.name
    api_competitor.stack = competitor.stack

    api_card = API::Card.new
    api_card.value = card.value
    api_card.suit = API::Suit.const_get(card.suit.to_sym)
    api_card.name = card.to_s

    @strategy.hole_card(api_competitor, api_card)
  end

  def bet(competitior, bet)
    api_competitor = API::Competitor.new
    api_competitor.name = competitior.name
    api_competitor.stack = competitior.stack

    api_bet = API::Bet.new
    api_bet.amount = bet[:amount]
    api_bet.type = API::BetType.const_get(bet[:type].capitalize)

    @strategy.bet(api_competitor, api_bet)
  end
end