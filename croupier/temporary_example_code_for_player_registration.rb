#
# This code will be rephrased as a test
#

$:.push('lib/api')

require 'thrift'
require 'croupier'

transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', 9090))
protocol = Thrift::BinaryProtocol.new(transport)
client = API::Croupier::Client.new(protocol)

transport.open()

client.register_player('localhost',9091)
client.register_player('localhost',9092)
client.start_sit_and_go()

transport.close()