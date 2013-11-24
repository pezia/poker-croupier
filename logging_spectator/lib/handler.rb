
class LoggingSpectator::Handler
  def name
    "Logger"
  end

  def competitor_status(competitor)
    LoggingSpectator.logger.info "#{competitor.name} has #{competitor.stack} chips"
  end

  def hole_card(competitor, card)
    LoggingSpectator.logger.info "#{competitor.name} got hole card #{card.name} (#{card.value}, #{card.suit})"
  end

  def community_card(card)
    LoggingSpectator.logger.info "community card #{card.name}"
  end

  def bet(competitor, bet)
    LoggingSpectator.logger.info "#{competitor.name} made a bet of #{bet.amount} (#{API::BetType::VALUE_MAP[bet.type]}) and is left with #{competitor.stack} chips"
    LoggingSpectator.logger.info "The pot now contains #{bet.new_pot_size} chips"
  end

  def winner(competitor, amount)
    LoggingSpectator.logger.info "#{competitor.name} won #{amount}"
  end
end