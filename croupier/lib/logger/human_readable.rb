
class Croupier::LogHandler::HumanReadable
  def competitor_status(competitor)
    Croupier.logger.info "#{competitor.name} has #{competitor.stack} chips"
  end

  def hole_card(competitor, card)
    Croupier.logger.info "#{competitor.name} got hole card #{card.name} (#{card.value}, #{card.suit})"
  end

  def community_card(card)
    Croupier.logger.info "community card #{card.name}"
  end

  def bet(competitor, bet)
    Croupier.logger.info "#{competitor.name} made a bet of #{bet[:amount]} (#{bet[:type]}) and is left with #{competitor.stack} chips"
    Croupier.logger.info "The pot now contains #{bet[:pot]} chips"
  end

  def showdown(competitor, hand)
    Croupier.logger.info "#{competitor.name} showed #{hand.cards.map{|card| card.name}.join(',')} making a #{hand.name}"
  end

  def winner(competitor, amount)
    Croupier.logger.info "#{competitor.name} won #{amount}"
  end
end
