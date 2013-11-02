require_relative '../spec_helper'



describe Croupier::GameSteps::Showdown do
  def run
    Croupier::GameSteps::Showdown.new(@game_state).run
  end

  def set_hole_cards_for(player_id, first_card, second_card)
    @game_state.players[player_id].hole_card Card.new first_card
    @game_state.players[player_id].hole_card Card.new second_card
  end

  before :each do
    @game_state = SpecHelper::MakeGameState.with(
        players: [fake_player, fake_player],
        spectators: [SpecHelper::FakeSpectator.new, SpecHelper::FakeSpectator.new]
    )

    @game_state.community_cards =
        ['3 of Diamonds', '5 of Clubs', 'Jack of Spades', 'Queen of Hearts', 'King of Clubs']
        .map { |name| Card.new name }
  end

  it "should create a hand for each player and compare them" do
    set_hole_cards_for(0, 'Jack of Clubs', 'Jack of Hearts')
    set_hole_cards_for(1, '4 of Clubs', 'Ace of Hearts')

    run
  end
end
