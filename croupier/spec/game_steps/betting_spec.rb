require_relative '../spec_helper'

describe Croupier::GameSteps::Betting do

  let(:game_state) { SpecHelper::MakeGameState.with players: [SpecHelper::FakePlayer.new, SpecHelper::FakePlayer.new] }

  it "should request a bet from the player in action" do
    game_state.players[0].should_receive(:bet_request).and_return(0)

    Croupier::GameSteps::Betting.new.run(game_state)
  end

  it "should transfer a non zero bet to the pot" do
    game_state.players[0].should_receive(:bet_request).and_return(20)

    Croupier::GameSteps::Betting.new.run(game_state)

    game_state.pot.should == 20
  end

end
