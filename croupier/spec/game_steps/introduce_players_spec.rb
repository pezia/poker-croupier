require_relative '../spec_helper.rb'

describe Croupier::GameSteps::IntroducePlayers do

  describe "#run" do
    it "should introduce each player to all other players" do
      first_player = double("First player")
      second_player = double("Second player")

      first_player.should_receive(:competitor_status).once.with(first_player)
      first_player.should_receive(:competitor_status).once.with(second_player)
      second_player.should_receive(:competitor_status).once.with(first_player)
      second_player.should_receive(:competitor_status).once.with(second_player)

      game_state = Croupier::GameState.new
      game_state.register_player first_player
      game_state.register_player second_player

      step = Croupier::GameSteps::IntroducePlayers.new
      step.run(game_state)
    end
  end

end