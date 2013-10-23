require_relative '../spec_helper'

describe Croupier::GameSteps::ShuffleCards do
  it "should shuffle the cards in the deck" do
    game_state = double("Game state")
    deck = double("Deck")

    game_state.stub(:deck).and_return(deck)
    deck.should_receive(:shuffle)

    Croupier::GameSteps::ShuffleCards.new(game_state).run
  end
end