class Croupier::Game::State
  attr_accessor :community_cards

  def initialize(tournament_state)
    @community_cards = []
    @tournament_state = tournament_state
  end

  def method_missing(method, *args, &block)
    @tournament_state.send(method, *args, &block)
  end
end