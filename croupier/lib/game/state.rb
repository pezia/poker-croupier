class Croupier::Game::State
  delegate_to :tournament_state

  attr_accessor :community_cards

  def initialize(tournament_state)
    @community_cards = []
    @tournament_state = tournament_state
  end
end