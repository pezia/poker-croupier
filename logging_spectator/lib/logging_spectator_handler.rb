
class LoggingSpectatorHandler
  def name
    ARGV.first
  end

  def competitor_status(competitor)
    p competitor
  end

  def hole_card(competitor, card)
    p "[#{competitor.name}] hole card #{card.name} (#{card.value}, #{card.suit})"
  end

  def community_card(card)
    p "community card #{card}"
  end

  def bet(competitor, bet)
    p competitor, bet
  end
end