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

      game_state.each_player_and_spectator do |observer|
        observer.the_message
      end
    end

    it "should send the messages to all spectators" do
      game_state = MakeGameState.with spectators: [double("First spectator"), double("Second spectator")]

      game_state.spectators.each do |spectator|
        spectator.should_receive(:the_message)
      end

      game_state.each_player_and_spectator do |observer|
        observer.the_message
      end
    end
  end

  describe "#send_message_to_spectators" do
    it "should not send the messages to the players" do
      game_state = MakeGameState.with players: [double("First player"), double("Second player")]

      game_state.each_spectator do |observer|
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

      game_state.each_spectator do |observer|
        observer.the_message
      end
    end
  end

  describe "#transfer_bet" do
    it "should transfer the amount requested from the player to the pot, and notify observers" do
      strategy = double("player strategy")
      game_state = MakeGameState.with players: [Croupier::Player.new(strategy, nil)]
      strategy.should_receive(:name).and_return("Joe")

      bet = API::Bet.new
      bet.amount = 40
      bet.type = API::BetType::Raise

      competitor = API::Competitor.new
      competitor.name = "Joe"
      competitor.stack = 960

      strategy.should_receive(:bet).with(competitor, bet)

      game_state.transfer_bet game_state.players.first, 40, :raise

      game_state.players.first.stack.should == 960
      game_state.pot.should == 40
    end
  end

  describe "#transfer_prize" do
    it "should transfer the amount requested from the pot ro the player" do
      game_state = MakeGameState.with players: [Croupier::Player.new(nil, nil)]

      game_state.transfer_prize game_state.players.first, 40

      game_state.players.first.stack.should == 1040
      game_state.pot.should == -40
    end

  end
end