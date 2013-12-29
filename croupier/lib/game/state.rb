class Croupier::Game::State
  delegate_all :tournament_state

  attr_accessor :community_cards

  def initialize(tournament_state)
    @community_cards = []
    @tournament_state = tournament_state
  end
end