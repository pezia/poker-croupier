
class Croupier::Croupier
  def initialize
    @players = []
  end

  def register_player(player)
    @players.push player
  end

  def start_sit_and_go
    @players.each do |other_player|
      @players.each { |player| player.competitor_status(other_player) }
    end
  end
end