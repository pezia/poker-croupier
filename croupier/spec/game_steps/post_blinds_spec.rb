require_relative '../spec_helper.rb'

describe Croupier::GameSteps::PostBlinds do
  it "should notify each player about the blinds that have been posted and update stacks" do
    game_state = MakeGameState.with players: [double("First player"), double("Second player")]

    small_blind = { amount: 10, type: :blind }
    big_blind = { amount: 20, type: :blind }

    game_state.players[0].should_receive(:withdraw).and_return(10)
    game_state.players[1].should_receive(:withdraw).and_return(20)
    game_state.players[0].should_receive(:bet).once.with(game_state.players[0], small_blind)
    game_state.players[0].should_receive(:bet).once.with(game_state.players[1], big_blind)
    game_state.players[1].should_receive(:bet).once.with(game_state.players[0], small_blind)
    game_state.players[1].should_receive(:bet).once.with(game_state.players[1], big_blind)

    step = Croupier::GameSteps::PostBlinds.new
    step.run(game_state)

    game_state.pot.should == 30
  end
end