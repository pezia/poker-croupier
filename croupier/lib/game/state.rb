class Croupier::Game::State
  attr_accessor :community_cards

  def initialize(tournament_state)
    @community_cards = []
    @tournament_state = tournament_state
  end

  def each_observer &block
    @tournament_state.each_observer &block
  end

  def each_player_from from_player, &block
    @tournament_state.each_player_from from_player, &block
  end

  def method_missing(method, *args)
    @tournament_state.send(method, *args)
  end
end