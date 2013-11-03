
class PlayerStrategy::Handler
  def name
    ARGV.first
  end

  def competitor_status(competitor)
    p competitor
  end

  def hole_card(card)
    p "hole card #{card.name} (#{card.value}, #{card.suit})"
  end

  def community_card(card)
    p "community card #{card}"
  end

  def bet(competitor, bet)
    p competitor, bet
  end

  def bet_request
    10 * rand(0..2)
  end

  def winner(competitor)
    p competitor
  end
end