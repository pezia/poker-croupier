$:.push('gen-rb')

require 'thrift'
require 'player'

begin
  port = ARGV[0] || 9090

  transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', port))
  protocol = Thrift::BinaryProtocol.new(transport)
  client = Player::Client.new(protocol)

  transport.open()

  client.new_game()

  transport.close()
rescue
  puts $!
end