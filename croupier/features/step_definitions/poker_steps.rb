require_relative '../../croupier'

Given(/^The croupier is ready for a game$/) do
  Croupier::TestFramework::TestCroupier.new_instance
end

Given(/^"([^"]*)" is a player$/) do |player_name|
  croupier = Croupier::TestFramework::TestCroupier.instance
  croupier.register_player Croupier::TestFramework::FakePlayer.new(player_name)
end
When(/^I start a sit and go$/) do
  Croupier::TestFramework::TestCroupier.instance.start_sit_and_go
end
Then(/^"([^"]*)" gets the following list of players:$/) do |player_name, received_statuses|
  player = Croupier::TestFramework::FakePlayerRegistry.instance.find(player_name)
  received_statuses.raw.each do |competitor_name|
    competitor = Croupier::TestFramework::FakePlayerRegistry.instance.find(competitor_name.first)
    player.next_message.should == [:competitor_status, competitor]
  end
end