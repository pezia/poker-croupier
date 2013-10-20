require_relative '../spec_helper.rb'

describe Croupier::GameSteps::Flop do

  before(:each) do
    @cards = ['6 of Diamonds', 'Jack of Hearts', 'Ace of Spades', 'King of Clubs'].map { |name| Card.new name }

    @deck = double("Deck")
    @deck.stub(:next_card!).and_return(*@cards)

    Croupier::Deck.stub(:new).and_return(@deck)

    @game_state = SpecHelper::MakeGameState.with(
          players: [SpecHelper::FakeStrategy.new, SpecHelper::FakeStrategy.new],
          spectators: [SpecHelper::FakeSpectator.new, SpecHelper::FakeSpectator.new]
    )
  end

  it "should deal three community cards and notify the players" do
    @game_state.players.each do |p|
      @cards[0..2].each do |card|
        p.should_receive(:community_card).with(card)
      end
    end

    step = Croupier::GameSteps::Flop.new
    step.run(@game_state)
  end

  it "should deal three community cards and notify the spectators" do
    @game_state.spectators.each do |s|
      @cards[0..2].each do |card|
        s.should_receive(:community_card).with(card)
      end
    end

    step = Croupier::GameSteps::Flop.new
    step.run(@game_state)
  end
end
