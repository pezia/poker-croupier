
class CroupierHandler
  def initialize
    @players = []
    @transports = []
  end

  def register_player(host, port)
    begin
      transport = Thrift::BufferedTransport.new(Thrift::Socket.new(host, port))
      protocol = Thrift::BinaryProtocol.new(transport)
      player = API::PlayerStrategy::Client.new(protocol)

      transport.open()
      p "Registered #{player.name()} at #{host}:#{port}"

      @players.push player
      @transports.push transport
    rescue
      puts $!
    end
  end


  def register_spectator(host, port)

  end

  def start_sit_and_go
    @players.each do |player|
      competitor = API::Competitor.new
      competitor.name = player.name
      competitor.stack = 1000

      @players.each { |other_player| other_player.competitor_status(competitor) }
    end
  end

end