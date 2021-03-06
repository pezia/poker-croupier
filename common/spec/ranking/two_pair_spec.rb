require_relative "spec_helper"

describe "Two Pair" do
  it 'should rank two pairs over a pair' do
    hand('Jack of Spades', 'Jack of Hearts', '10 of Spades', '10 of Hearts').
        should_defeat hand('Queen of Spades', 'Queen of Hearts', 'Jack of Hearts', '10 of Diamonds')
  end

  it 'should rank a higher two pair higher' do
    hand('Queen of Spades', 'Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs').
        should_defeat hand('King of Spades', '10 of Spades', '10 of Hearts', '9 of Diamonds', '9 of Clubs')
  end

  it 'should rank two pair based on second pair' do
    hand('Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs','Ace of Hearts').
        should_defeat hand('Jack of Spades', 'Jack of Hearts', '7 of Diamonds', '7 of Clubs','Ace of Hearts')
  end

  it 'should rank two pairs based on the kicker' do
    hand('Queen of Spades', 'Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs').
        should_defeat hand('2 of Spades', 'Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs')
  end

  it "should tie two pairs with the same kicker" do
    hand('Queen of Spades', 'Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs', '7 of Clubs', '6 of Clubs').
        should_tie_with hand('Queen of Spades', 'Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs', '5 of Clubs','4 of Clubs')
  end

  it 'should rank three pair higher if third pair is a higher kicker' do
    hand('Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs','7 of Diamonds','7 of Clubs').
        should_defeat hand('Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs','6 of Hearts', '5 of Hearts')
  end

  it 'should be called two pairs' do
    hand('Jack of Spades', 'Jack of Hearts', '8 of Diamonds', '8 of Clubs','Ace of Hearts').name.should == 'two pairs'
  end
end
