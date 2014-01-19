#
# This code will be rephrased as a test
#

$:.push('lib/api')

require_relative 'functions'

number_of_players = (ARGV.length > 0) ? ARGV[0].to_i : 3

player_names = %w(Albert Bob Chuck Daniel Emily Franky George Huge Ivan Joe Kevin Leo Mike Nikki Oliver Peter Q Robert Steve Tom Ulric Victor Walt Xavier Yvette Zara)

players = []

player_names[0..number_of_players-1].each_with_index do |player_name, index|
  players[index] = fork do
    exec "bundle exec ruby ../../player/rb/player_service.rb '#{player_name}' #{9200+index}"
  end
end

players.each do |player|
  Process.detach(player)
end

sit_and_go 'game.log' do
  players.each_index do |index|
    register_player('localhost',9200+index)
  end
end

