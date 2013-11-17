
class PlayerStrategy::Handler
  def name
    ARGV.first
  end

  def competitor_status(competitor)
  end

  def hole_card(card)
  end

  def community_card(card)
  end

  def bet(competitor, bet)
  end

  def bet_request
    10 * rand(0..2)
  end

  def winner(competitor)
  end
end