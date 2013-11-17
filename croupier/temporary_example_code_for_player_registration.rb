#
# This code will be rephrased as a test
#

$:.push('lib/api')

number_of_players = (ARGV.length > 0) ? ARGV[0].to_i : 3

player_names = %w(Albert Bob Chuck Daniel Emily Franky George Huge Ivan Joe Kevin Leo Mike Nikki Oliver Peter Q Robert Steve Tom Ulric Victor Walt Xavier Yvette Zara)

players = []

player_names[0..number_of_players-1].each_with_index do |player_name, index|
  players[index] = fork do
    exec "bundle exec ruby ../player/rb/player_service.rb '#{player_name}' #{9200+index}"
  end
end

players.each do |player|
  Process.detach(player)
end

logger = fork do
  exec "bundle exec ruby ../logging_spectator/logging_spectator_service.rb 9100"
end
Process.detach(logger)

croupier = fork do
  exec "bundle exec ruby croupier_service.rb"
end
Process.detach(croupier)

sleep(2)

require 'thrift'
require 'croupier'

transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', 9090))
protocol = Thrift::BinaryProtocol.new(transport)
client = API::Croupier::Client.new(protocol)

transport.open()

players.each_index do |index|
  client.register_player('localhost',9200+index)
end

client.register_spectator('localhost',9100)
client.start_sit_and_go()

transport.close()