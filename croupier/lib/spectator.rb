class Croupier::Spectator < Croupier::ThriftObserver
  def hole_card(competitor, card)
    strategy.hole_card(gateway[competitor], gateway[card])
  end
end