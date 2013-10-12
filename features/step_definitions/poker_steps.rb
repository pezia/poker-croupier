$:.push(File.join(File.dirname(__FILE__), '../../common/lib'))

require_relative '../../croupier/croupier'
require 'card'
require 'cucumber/rspec/doubles'


Given(/^the croupier is ready for a game$/) do
  Croupier::TestFramework::TestCroupier.new_instance
end



Given(/^"([^"]*)" is a player$/) do |player_name|
  croupier = Croupier::TestFramework::TestCroupier.instance
  croupier.register_player Croupier::TestFramework::FakePlayer.new(player_name)
end



When(/^I start a sit and go$/) do
  Croupier::TestFramework::TestCroupier.instance.start_sit_and_go
end



Then(/^Players get the following list of players:$/) do |received_statuses|
  Croupier::TestFramework::FakePlayerRegistry.instance.each do |player|
    received_statuses.raw.each do |competitor_name|
      competitor = Croupier::TestFramework::FakePlayerRegistry.instance.find(competitor_name.first)
      player.next_message.should == [:competitor_status, competitor]
    end
  end
end



Then(/^the deck contains the following cards:$/) do |table|
  fake_deck = double("Fake deck")
  list_of_cards_in_deck = table.raw.map { |name| Card.new name.first }

  fake_deck.should_receive(:shuffle)
  fake_deck.stub(:next_card!).and_return(*list_of_cards_in_deck)
  Croupier::Deck.stub(:new).and_return(fake_deck)
end



Then(/^"([^"]*)" gets the following hole cards:$/) do |player_name, cards|
  player = Croupier::TestFramework::FakePlayerRegistry.instance.find(player_name)
  cards.raw.each do |card_name|
    card = Card.new(card_name.first)
    player.next_message.should == [:hole_card, card]
  end
end


When(/^"([^"]*)" is reported to have posted the (small|big) blind$/) do |player_name, blind_size|
  croupier = Croupier::TestFramework::TestCroupier.instance
  blind = (blind_size == "big") ? croupier.big_blind : croupier.small_blind

  betting_player = Croupier::TestFramework::FakePlayerRegistry.instance.find(player_name)

  bet = { amount: blind, type: :blind }

  Croupier::TestFramework::FakePlayerRegistry.instance.each do |player|
    player.next_message.should == [:bet, betting_player, bet]
  end

end
