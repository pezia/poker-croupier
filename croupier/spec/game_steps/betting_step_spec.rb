require_relative '../spec_helper'


describe Croupier::GameSteps::BettingStep do
  before :each do
    @spectator = SpecHelper::FakeSpectator.new
    @player1 = Croupier::Player.new SpecHelper::FakeStrategy.new

    @game_state = SpecHelper::MakeGameState.with players: [@player1], spectators: [@spectator]
  end

  def should_bet(player, amount, type)
    should_try_bet player, amount, amount, type
  end

  def should_try_bet(player, requested_amount, actual_amount, type)
    player.should_receive(:bet_request).and_return(requested_amount)
    @spectator.should_receive(:bet).with(player, amount: actual_amount, type: type)
  end

  def run()
    Croupier::GameSteps::BettingStep.new(@game_state).run
  end

  context "at least two players" do

    before :each do
      @player2 = Croupier::Player.new SpecHelper::FakeStrategy.new
      @game_state.register_player @player2
    end


    it "should request a bet from the player in action, and the player should remain active" do
      should_bet(@player1, 0, :check)
      should_bet(@player2, 0, :check)
      run
      @player1.active?.should == true
    end

    it "should transfer a non zero bet to the pot" do
      should_bet @player2, 20, :raise
      should_bet @player1, 0, :fold
      run
      @game_state.pot.should == 20
      @player2.stack.should == 980
    end

    it "should skip betting if one of the two players has already folded" do
      @player1.fold
      run
    end

    it "should skip betting if one of the two players is already all in" do
      @player1.stack = 0
      run
    end

    it "should ask the second player after the first player" do
      should_bet @player1, 0, :check
      should_bet @player2, 0, :check
      run
    end

    it "should transfer non zero bets to the pot" do
      should_bet @player2, 20, :raise
      should_bet @player1, 20, :call
      run
      @game_state.pot.should == 40
      @player1.stack.should == 980
      @player2.stack.should == 980
    end

    it "should ask the first player again if the second raises" do
      should_bet @player2, 20, :raise
      should_bet @player1, 40, :raise
      should_bet @player2, 20, :call
      run
      @game_state.pot.should == 80
      @player1.stack.should == 960
      @player2.stack.should == 960
    end

    it "should interpret a zero bet after a raise as a fold" do
      should_bet @player2, 20, :raise
      should_bet @player1, 0, :fold
      run
      @game_state.pot.should == 20
    end

    it "should mark a folded player inactive" do
      should_bet @player2, 20, :raise
      should_bet @player1, 0, :fold
      run
      @player1.active?.should == false
    end

    it "should keep track of the total_bet for each player" do
      should_bet @player2, 20, :raise
      should_bet @player1, 0, :fold
      run
      @player2.total_bet.should == 20
      @player1.total_bet.should == 0
    end

    it "should interpret a bet smaller then necessary to call as a fold" do
      should_bet @player2, 20, :raise
      should_try_bet @player1, 19, 0, :fold

      run

      @game_state.pot.should == 20
      @player1.stack.should == 1000
      @player1.total_bet.should == 0
    end

    it "should interpret a bet smaller than the big blind as a check when no other bet has been place before" do
      should_bet @player1, 0, :check
      should_try_bet @player2, 19, 0, :check

      run
    end

    it "should interpret a bet smaller than the previous raise as a call" do
      should_bet @player2, 20, :raise
      should_try_bet @player1, 39, 20, :call

      run

      @game_state.pot.should == 40
      @player1.stack.should == 980
      @player1.total_bet.should == 20
    end

    it "should increase the minimum raise to the current raise if it is larger then the current minimum raise" do
      should_bet @player2, 60, :raise
      should_try_bet @player1, 119, 60, :call

      run

      @game_state.pot.should == 120
      @player1.stack.should == 940
      @player1.total_bet.should == 60
    end

    it "should increase the minimum raise to the current raise by allin if it is larger then the current minimum raise" do
      @player2.stack = 60
      should_bet @player2, 60, :allin
      should_try_bet @player1, 119, 60, :call

      run

      @game_state.pot.should == 120
      @player1.stack.should == 940
      @player1.total_bet.should == 60
    end

    it "should skip inactive players" do
      @player3 = Croupier::Player.new SpecHelper::FakeStrategy.new
      @game_state.register_player @player3

      should_bet @player2, 20, :raise
      should_bet @player3, 0, :fold
      should_bet @player1, 40, :raise
      should_bet @player2, 20, :call
      run
    end


    context "player has less money then needed to call" do
      before :each do
        @player2.stack = 20
        should_bet @player1, 100, :raise
      end

      it "should let a player go all in" do
        should_bet @player2, 20, :allin

        run

        @player2.stack.should == 0
        @player2.total_bet.should == 20

        @game_state.pot.should == 120
      end

      it "should treat larger bet as an all in" do
        should_try_bet @player2, 40, 20, :allin

        run

        @player2.stack.should == 0
        @player2.total_bet.should == 20

        @game_state.pot.should == 120

      end
    end


    it "should report an empty pot with nothing to call and the big blind as minimum raise" do
      @player2.should_receive(:bet_request).with(0, {:to_call=>0, :minimum_raise=>20}).and_return(0)
      @player1.should_receive(:bet_request).with(0, {:to_call=>0, :minimum_raise=>20}).and_return(0)

      run
    end

    it "should report a non empty pot and suitable limits if a player already bet" do
      @player2.should_receive(:bet_request).with(0, {:to_call=>0, :minimum_raise=>20}).and_return(20)
      @player1.should_receive(:bet_request).with(20, {:to_call=>20, :minimum_raise=>20}).and_return(60)
      @player2.should_receive(:bet_request).with(80, {:to_call=>40, :minimum_raise=>40}).and_return(20)

      run
    end

  end

end
