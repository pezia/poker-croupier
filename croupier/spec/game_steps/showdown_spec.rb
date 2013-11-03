require_relative '../spec_helper'
require 'card'
require 'ranking/hand'


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

    @observers = @game_state.players + @game_state.spectators

    @game_state.community_cards =
        ['3 of Diamonds', 'Jack of Clubs', 'Jack of Spades', 'Queen of Spades', 'King of Spades']
        .map { |name| Card.new name }
  end

  it "should report the first player as a winner if it has a better hand" do
    set_hole_cards_for(0, 'Jack of Diamonds', 'Jack of Hearts')
    set_hole_cards_for(1, '4 of Clubs', 'Ace of Hearts')


    @observers.each do |observer|
      observer.should_receive(:winner).with(@game_state.players.first)
    end

    run
  end

  it "should report the second player as a winner if it has a better hand" do
    set_hole_cards_for(0, '4 of Clubs', 'Ace of Hearts')
    set_hole_cards_for(1, 'Jack of Diamonds', 'Jack of Hearts')

    @observers.each do |observer|
      observer.should_receive(:winner).with(@game_state.players.last)
    end

    run
  end

  it "should skip inactive players" do
    set_hole_cards_for(0, 'Jack of Diamonds', 'Jack of Hearts')
    set_hole_cards_for(1, '4 of Clubs', 'Ace of Hearts')

    @game_state.players.first.fold

    @observers.each do |observer|
      observer.should_receive(:winner).with(@game_state.players.last)
    end

    run
  end

  it "should report multiple winners when players have identical hands" do
    set_hole_cards_for(0, '4 of Clubs', 'Jack of Hearts')
    set_hole_cards_for(1, '4 of Hearts', 'Jack of Diamonds')

    @observers.each do |observer|
      observer.should_receive(:winner).with(@game_state.players.first)
      observer.should_receive(:winner).with(@game_state.players.last)
    end

    run
  end
end
