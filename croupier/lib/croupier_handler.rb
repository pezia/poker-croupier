
class CroupierHandler
  def initialize
    @players = []
    @transports = []
  end

  def register_player(host, port)
    begin
      transport = Thrift::BufferedTransport.new(Thrift::Socket.new(host, port))
      protocol = Thrift::BinaryProtocol.new(transport)
      player = Player::Client.new(protocol)

      transport.open()
      p "Registered #{player.name()} at #{host}:#{port}"
      transport.close()

      @players.push player
      @transports.push transport


    rescue
      puts $!
    end
  end


  def register_spectator(host, port)

  end

  def start_sit_and_go

  end

  def start_live_action_game

  end
end