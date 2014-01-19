
class Croupier::Handler
  def initialize
    @croupier = Croupier::Tournament::Runner.new
    @croupier.register_spectator Croupier::LogHandler::HumanReadable.new
  end

  def register_player(host, port)
      begin
        player = Croupier::PlayerBuilder.new.build_player(host, port)
        player.open
        @croupier.register_player player
        Croupier.logger.info "Connected #{player.name} at #{host}:#{port}"
      rescue Exception => e
        Croupier.logger.error $!.message
        raise e
      end
  end


  def register_spectator(host, port)
    begin
      spectator = Croupier::SpectatorBuilder.new.build_spectator(host, port)
      spectator.open
      @croupier.register_spectator spectator
      Croupier.logger.info "Connected #{spectator.name} at #{host}:#{port}"
    rescue Exception => e
      Croupier.logger.error $!.message
      raise e
    end
  end

  def start_sit_and_go
    @croupier.start_sit_and_go.get.reverse.each_with_index do |player, index|
      Croupier.logger.info "Place #{index+1}: #{player.name}"
    end
  end

  def shutdown
    Croupier.logger.close
    abort('Shutting down server')
  end

end