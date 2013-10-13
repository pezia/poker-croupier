#
# This code will be rephrased as a test
#

$:.push('lib/api')


player1 = fork do
  exec "bundle exec ruby ../player/rb/player.rb 'Daniel' 9091"
end

player2 = fork do
  exec "bundle exec ruby ../player/rb/player.rb 'Robert' 9092"
end

logger = fork do
  exec "bundle exec ruby ../logging_spectator/logging_spectator.rb 9093"
end

croupier = fork do
  exec "bundle exec ruby croupier_service.rb"
end

Process.detach(player1)
Process.detach(player2)
Process.detach(logger)
Process.detach(croupier)

sleep(1)

require 'thrift'
require 'croupier'

transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', 9090))
protocol = Thrift::BinaryProtocol.new(transport)
client = API::Croupier::Client.new(protocol)

transport.open()

client.register_player('localhost',9091)
client.register_player('localhost',9092)
client.register_spectator('localhost',9093)
client.start_sit_and_go()

transport.close()