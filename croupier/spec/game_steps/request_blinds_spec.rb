require_relative '../spec_helper'

describe Croupier::GameSteps::RequestBlinds do
  before :each do
    @player1 = fake_player
    @player2 = fake_player
    @player3 = fake_player

    @game_state = SpecHelper::MakeGameState.with players: [@player1, @player2, @player3]

    @step = Croupier::GameSteps::RequestBlinds.new @game_state
  end

  it "should request the first player to post the small blind" do
    @player1.should_receive(:force_bet).with(@game_state.small_blind)
    @step.run
  end

  it "should request the second player to post the big blind" do
    @player2.should_receive(:force_bet).with(@game_state.big_blind)
    @step.run
  end
end