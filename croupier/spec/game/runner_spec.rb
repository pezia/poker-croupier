require_relative '../spec_helper'

describe Croupier::Tournament::Runner do
  before :each do
    @tournament_state = Croupier::Tournament::State.new
    Croupier::Tournament::State.stub(:new).and_return(@tournament_state)

    @runner = Croupier::Tournament::Runner.new
  end

  describe "#register_player" do
    it "should add the player to the game state" do
      player = double("Player")
      @runner.register_player(player)

      @tournament_state.players.should == [player]
    end
  end

  describe "#register_spectator" do
    it "should add the spectator to the game state" do
      spectator = double("Spectator")
      @runner.register_spectator(spectator)

      @tournament_state.spectators.should == [spectator]
    end
  end

  describe "#start_sit_and_go" do
    it "should run steps until there are more than two players in game" do
      @tournament_state.stub(:number_of_active_players_in_tournament).and_return(2, 1)
      game_state = Croupier::Game::State.new(@tournament_state)
      Croupier::Game::State.stub(:new).and_return(game_state)
      Croupier::Game::Runner::GAME_STEPS.each do |step|
        instance = double("Game step")
        step.should_receive(:new).with(game_state).and_return(instance)
        instance.should_receive(:run)
      end

      @tournament_state.should_receive(:next_round!)

      @runner.start_sit_and_go
    end

  end
end