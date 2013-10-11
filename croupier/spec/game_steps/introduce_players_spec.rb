require_relative '../spec_helper.rb'

describe Croupier::GameSteps::IntroducePlayers do
  it "should introduce each player to all other players" do
    game_state = MakeGameState.with double("First player"), double("Second player")

    game_state.players[0].should_receive(:competitor_status).once.with(game_state.players[0])
    game_state.players[0].should_receive(:competitor_status).once.with(game_state.players[1])
    game_state.players[1].should_receive(:competitor_status).once.with(game_state.players[0])
    game_state.players[1].should_receive(:competitor_status).once.with(game_state.players[1])

    step = Croupier::GameSteps::IntroducePlayers.new
    step.run(game_state)
  end
end