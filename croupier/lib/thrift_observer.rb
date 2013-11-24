class Croupier::ThriftObserver
  attr_reader :gateway
  attr_reader :strategy

  def initialize(strategy, transport)
    @strategy = strategy
    @transport = transport
    @gateway = Croupier::ThriftEntityGateway
  end

  def open
    @transport.open
  end

  def close
    @transport.close
  end

  def competitor_status(competitor)
    @strategy.competitor_status @gateway[competitor]
  end

  def name
    @name ||= @strategy.name
  end

  def bet(competitor, bet)
    @strategy.bet(@gateway[competitor], @gateway.bet(bet))
  end

  def community_card(card)
    @strategy.community_card @gateway[card]
  end

  def showdown(hand)

  end

  def winner(competitor, amount)
    @strategy.winner @gateway[competitor], amount
  end
end