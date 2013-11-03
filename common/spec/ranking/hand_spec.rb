require_relative 'spec_helper'


describe Ranking::Hand do
  it "should accept cards in it's constructor" do
    card = Card.new('6 of Hearts')

    hand = Ranking::Hand.new(card)

    hand.cards.first.should == card
  end

  it "should accept card name in it's constructor" do
    card = Card.new('6 of Hearts')

    hand = Ranking::Hand.new('6 of Hearts')

    hand.cards.first.should == card
  end

  it "should throw an exception if anything other than a card or card name is passed" do
    expect { Ranking::Hand.new(Date.new) }.to raise_error "Hand initializer expects a card or a card name"
  end

  it "should rank the empty hand below any other hand" do
    empty_hand = Ranking::Hand.new
    other_hand = Ranking::Hand.new('2 of Hearts')

    empty_hand.defeats?(other_hand).should == false
    other_hand.defeats?(empty_hand).should == true
  end
end