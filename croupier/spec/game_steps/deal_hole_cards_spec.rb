require_relative '../spec_helper.rb'

describe Croupier::GameSteps::DealHoleCards do
  it "should deal two cards to all of the players" do
    cards = ['6 of Diamonds', 'Jack of Hearts', 'Ace of Spades', 'King of Clubs'].map { |name| Card.new name }

    deck = double("Deck")
    deck.stub(:next_card!).and_return(*cards)

    Croupier::Deck.stub(:new).and_return(deck)

    game_state = MakeGameState.with players: [double("First player"), double("Second player")]

    game_state.players[0].should_receive(:hole_card).once.with(cards[0])
    game_state.players[1].should_receive(:hole_card).once.with(cards[1])
    game_state.players[0].should_receive(:hole_card).once.with(cards[2])
    game_state.players[1].should_receive(:hole_card).once.with(cards[3])

    step = Croupier::GameSteps::DealHoleCards.new
    step.run(game_state)
  end
end