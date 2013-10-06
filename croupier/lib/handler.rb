
require_relative 'player_builder'
require_relative 'croupier'

class Croupier::Handler
  def initialize
    @croupier = Croupier::Croupier.new
  end

  def register_player(host, port)
      begin
        player = Croupier::PlayerBuilder.new.build_player(host, port)
        @croupier.register_player player
        Croupier.logger.info "Connected #{player.name} at #{host}:#{port}"
      rescue Exception => e
        p e
        Croupier.logger.error $!.message
        raise e
      end
  end


  def register_spectator(host, port)

  end

  def start_sit_and_go
    @croupier.start_sit_and_go
  end

end