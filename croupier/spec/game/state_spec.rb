require_relative '../spec_helper'

describe Croupier::Game::State do

  describe "#transfer_bet" do
    it "should transfer the amount requested from the player to the pot, and notify observers" do
      api_player = double("player strategy")
      game_state = Croupier::Game::State.new(SpecHelper::MakeTournamentState.with players: [Croupier::Player.new(Croupier::PlayerStrategy.new(api_player, nil))])
      api_player.should_receive(:name).and_return("Joe")

      bet = API::Bet.new
      bet.amount = 40
      bet.type = API::BetType::Raise
      bet.new_pot_size = 40

      competitor = API::Competitor.new
      competitor.name = "Joe"
      competitor.stack = 960

      api_player.should_receive(:bet).with(competitor, bet)

      game_state.transfer_bet game_state.players.first, 40, :raise

      game_state.players.first.stack.should == 960
      game_state.pot.should == 40
    end
  end

  describe "#last_aggressor" do
    let(:game_state) { game_state = Croupier::Game::State.new(SpecHelper::MakeTournamentState.with(players: [fake_player('a'), fake_player('b'), fake_player('c')])) }

    it "should return the first_player if there was no aggression" do
      game_state.last_aggressor.should == game_state.first_player
    end

    it "should return the second player if it raises" do
      game_state.transfer_bet game_state.second_player, 100, :raise

      game_state.last_aggressor.should == game_state.second_player
    end

    it "should return the dealer if it raises" do
      game_state.transfer_bet game_state.dealer, 100, :raise

      game_state.last_aggressor.should == game_state.dealer
    end

    it "should return the first_player if the second_player just calls" do
      game_state.transfer_bet game_state.first_player, 100, :raise
      game_state.transfer_bet game_state.second_player, 100, :call

      game_state.last_aggressor.should == game_state.first_player
    end

    context "after an aggression when #reset_last_aggressor is called" do
      it "should return the first_player again" do
        game_state.transfer_bet game_state.second_player, 100, :raise
        game_state.reset_last_aggressor
        game_state.last_aggressor.should == game_state.first_player
      end
    end
  end

end