
class Croupier::TestFramework::FakePlayerRegistry
  def initialize
    @players = {}
  end

  def add(player)
    @players[player.name] = player
  end

  def find(player_name)
    @players[player_name]
  end

  def self.instance
    @inst ||= self.new
  end
end