require_relative '../spec_helper.rb'

describe Croupier::Game::Steps::IntroducePlayers do
  it "should introduce each player to all other players" do
    game_state = SpecHelper::MakeGameState.with players: [double("First player"), double("Second player")]

    game_state.players[0].should_receive(:competitor_status).once.with(game_state.players[0])
    game_state.players[0].should_receive(:competitor_status).once.with(game_state.players[1])
    game_state.players[1].should_receive(:competitor_status).once.with(game_state.players[0])
    game_state.players[1].should_receive(:competitor_status).once.with(game_state.players[1])

    Croupier::Game::Steps::IntroducePlayers.new(game_state).run
  end
end