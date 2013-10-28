require_relative 'spec_helper.rb'

describe Croupier::Player do
  describe "#bet_request" do
    let(:strategy) { double("Player strategy") }
    let(:player) { Croupier::Player.new(strategy) }

    it "should delegate calls to the player strategy" do
      strategy.should_receive(:bet_request).and_return(30)

      player.bet_request.should == 30
    end

    it "should respond with forced bet after receiving #force_bet" do
      player.force_bet 20
      player.bet_request.should == 20
    end

    it "should delegate bet_request after forced bet has been posted" do
      player.force_bet 20
      strategy.should_receive(:bet_request).and_return(30)

      player.bet_request.should == 20
      player.bet_request.should == 30
    end
  end
end