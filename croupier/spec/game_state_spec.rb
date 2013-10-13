require_relative 'spec_helper'

describe Croupier::GameState do
  describe "#regirster_player" do
    it "should add the player to the list of players" do
      first_player = double("First player")
      second_player = double("Second player")

      game_state = Croupier::GameState.new
      game_state.register_player(first_player)
      game_state.register_player(second_player)

      game_state.players.should == [first_player, second_player]
    end
  end

  describe "#register_spectator" do
    it "should add tge spectator to the list of spectators" do
      spectator = double("Spectator")

      game_state = Croupier::GameState.new
      game_state.register_spectator(spectator)

      game_state.spectators.should == [spectator]
    end
  end

  describe "#send_message_to_everyone" do
    it "should send the messages to each player" do
      game_state = MakeGameState.with players: [double("First player"), double("Second player")]

      game_state.players.each do |player|
        player.should_receive(:the_message)
      end

      game_state.send_message_to_everyone do |observer|
        observer.the_message
      end
    end

    it "should send the messages to all spectators" do
      game_state = MakeGameState.with spectators: [double("First spectator"), double("Second spectator")]

      game_state.spectators.each do |spectator|
        spectator.should_receive(:the_message)
      end

      game_state.send_message_to_everyone do |observer|
        observer.the_message
      end
    end
  end

  describe "#send_message_to_spectators" do
    it "should not send the messages to the players" do
      game_state = MakeGameState.with players: [double("First player"), double("Second player")]

      game_state.send_message_to_spectators do |observer|
        observer.the_message
      end
    end

    it "should send the messages to all spectators" do
      game_state = MakeGameState.with(
          players: [double("First player"), double("Second player")],
          spectators: [double("First spectator"), double("Second spectator")]
      )

      game_state.spectators.each do |spectator|
        spectator.should_receive(:the_message)
      end

      game_state.send_message_to_spectators do |observer|
        observer.the_message
      end
    end
  end
end