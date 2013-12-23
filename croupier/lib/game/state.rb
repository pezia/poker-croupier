class Croupier::Game::State < SimpleDelegator

  attr_accessor :community_cards

  def initialize(tournament_state)
    super tournament_state
    @community_cards = []
    @tournament_state = tournament_state
  end
end