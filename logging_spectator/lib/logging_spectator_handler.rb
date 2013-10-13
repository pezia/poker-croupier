
class LoggingSpectatorHandler
  def name
    ARGV.first
  end

  def competitor_status(competitor)
    p "#{competitor.name} has #{competitor.stack} chips"
  end

  def hole_card(competitor, card)
    p "#{competitor.name} got hole card #{card.name} (#{card.value}, #{card.suit})"
  end

  def community_card(card)
    p "community card #{card.name}"
  end

  def bet(competitor, bet)
    p "#{competitor.name} made a bet of #{bet.amount} (#{bet.type}) and is left with #{competitor.stack} chips"
  end
end