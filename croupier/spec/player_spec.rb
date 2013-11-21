require_relative 'spec_helper.rb'

describe Croupier::Player do

  let(:strategy) { SpecHelper::FakeStrategy.new }
  let(:player) { Croupier::Player.new(strategy) }

  describe "#bet_request" do

    it "should delegate calls to the player strategy" do
      strategy.should_receive(:bet_request).with(60, to_call: 20, minimum_raise: 40).and_return(30)

      player.bet_request(60, to_call: 20, minimum_raise: 40).should == 30
    end

    it "should respond with forced bet after receiving #force_bet" do
      player.force_bet 20
      player.bet_request(0, {}).should == 20
    end

    it "should delegate bet_request after forced bet has been posted" do
      player.force_bet 20
      strategy.should_receive(:bet_request).with(60, to_call: 20, minimum_raise: 40).and_return(30)

      player.bet_request(0, {}).should == 20
      player.bet_request(60, to_call: 20, minimum_raise: 40).should == 30
    end
  end

  describe "#hole_card" do
    it "should delegate calls to the player strategy" do
      card = Card.new('6 of Diamonds')

      strategy.should_receive(:hole_card).with(card)

      player.hole_card card
    end

    it "should store hole cards for later use" do
      card1 = Card.new('6 of Diamonds')
      card2 = Card.new('King of Spades')

      player.hole_card card1
      player.hole_card card2

      player.hole_cards.should == [card1, card2]
    end
  end

  describe "#initialize_round" do
    it "should reset values related to a single round of poker" do
      player.fold
      player.total_bet = 100
      player.hole_cards << "Ace of spades"

      player.initialize_round

      player.active?.should be_true
      player.allin?.should be_false
      player.total_bet.should == 0
      player.hole_cards.should == []
    end
  end
end