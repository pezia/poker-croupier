require_relative "spec_helper"

describe "Flush" do
  it 'should rank a flush over a straight' do
    hand('2 of Hearts', '4 of Hearts', '5 of Hearts', '9 of Hearts', 'Jack of Hearts').
        should_defeat hand('9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds', 'King of Diamonds')

    hand('2 of Clubs', '4 of Clubs', '5 of Clubs', '9 of Clubs', 'Jack of Clubs').
        should_defeat hand('9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds', 'King of Diamonds')
  end

  it 'should ignore extra cards in a flush' do
    hand('2 of Hearts', '4 of Hearts', '5 of Hearts', '9 of Hearts', 'Jack of Hearts', 'Jack of Clubs').
        should_defeat hand('9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds', 'King of Diamonds')

    hand('2 of Hearts', '4 of Hearts', '5 of Hearts', '9 of Hearts', 'Jack of Hearts', 'King of Hearts').
        should_defeat hand('9 of Spades', '10 of Spades', 'Jack of Hearts', 'Queen of Diamonds', 'King of Diamonds')
  end

  it 'should rank higher flush higher' do
    hand('2 of Hearts', '4 of Hearts', '5 of Hearts', '9 of Hearts', 'King of Hearts').
        should_defeat hand('2 of Clubs', '4 of Clubs', '5 of Clubs', '9 of Clubs', 'Jack of Clubs')
  end
end
