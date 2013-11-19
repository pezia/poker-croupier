require_relative '../spec_helper/'


describe Croupier::GameSteps::PreFlopBettingStep do

  let(:spectator) { SpecHelper::FakeSpectator.new }
  let(:game_state) do
    SpecHelper::MakeGameState.with(
        players: [fake_player("Albert"), fake_player("Bob")],
        spectators: [spectator]
    )
  end

  def should_bet(player, amount, type)
    player.should_receive(:bet_request).and_return(amount)
    expect_bet_announced amount, player, type
  end

  def expect_bet_announced(amount, player, type)
    spectator.should_receive(:bet).with(player, amount: amount, type: type)
  end

  def run()
    Croupier::GameSteps::PreFlopBettingStep.new(game_state).run
  end

  it "should report the blinds than ask other players for their bets" do
    expect_bet_announced 10, game_state.first_player, :raise
    expect_bet_announced 20, game_state.second_player, :raise

    game_state.first_player.strategy.should_receive(:bet_request).and_return(0)
    expect_bet_announced 0, game_state.first_player, :fold

    run
  end
end