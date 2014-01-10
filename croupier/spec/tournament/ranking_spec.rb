require_relative '../spec_helper'

describe Croupier::Tournament::Ranking do
  let(:state) { SpecHelper::MakeTournamentState.with(players: [fake_player('a'), fake_player('b'), fake_player('c')]) }
  let(:ranking) { Croupier::Tournament::Ranking.new(state) }

  it "should return empty array" do
    ranking.get.should == []
  end

  it "should return the player that has been eliminated" do
    state.players[1].stack = 0

    ranking.eliminate
    ranking.get.should == [state.players[1]]
  end

  it "should only add each player once" do
    state.players[1].stack = 0

    ranking.eliminate
    ranking.eliminate
    ranking.get.should == [state.players[1]]
  end

  it "should return all players eliminated" do
    state.players[0].stack = 0
    state.players[1].stack = 0

    ranking.eliminate
    ranking.get.should == [state.players[1], state.players[0]]
  end

  it "should return players in order of elimination" do
    state.players[0].stack = 0
    ranking.eliminate
    state.players[1].stack = 0
    ranking.eliminate

    ranking.get.should == [state.players[0], state.players[1]]
  end
end