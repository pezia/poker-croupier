require_relative '../spec_helper'

describe Croupier::GameSteps::Betting do
  before :each do
    @player1 = Croupier::Player.new SpecHelper::FakeStrategy.new
    @game_state = SpecHelper::MakeGameState.with players: [@player1]
  end

  it "should request a bet from the player in action" do
    @player1.should_bet 0
    run
  end

  def run()
    Croupier::GameSteps::Betting.new.run(@game_state)
  end

  it "should transfer a non zero bet to the pot" do
    @player1.should_bet 20
    run
    @game_state.pot.should == 20
    @player1.stack.should == 980
  end

  context "at least two players" do

    before :each do
      @player2 = Croupier::Player.new SpecHelper::FakeStrategy.new
      @game_state.register_player @player2
    end

    it "should ask the second player after the first player" do
      @player1.should_bet 0
      @player2.should_bet 0
      run
    end

    it "should transfer non zero bets to the pot" do
      @player1.should_bet 20
      @player2.should_bet 20
      run
      @game_state.pot.should == 40
      @player1.stack.should == 980
      @player2.stack.should == 980
    end

    pending "need to isolate Player from API" do
      it "should ask the first player again if the second raises" do
        @player1.should_bet 20
        @player2.should_bet 40
        @player1.should_bet 20
        run
        @game_state.pot.should == 80
        @player1.stack.should == 960
        @player2.stack.should == 960
      end
    end

  end
end
