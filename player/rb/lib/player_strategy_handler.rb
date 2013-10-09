
class PlayerStrategyHandler
  def name
    ARGV.first
  end

  def competitor_status(competitor)
    p competitor
  end

  def hole_card(card)
    p "hole card #{card.value} of #{card.suit}"
  end

  def community_card(card)
    p "community card #{card}"
  end
end