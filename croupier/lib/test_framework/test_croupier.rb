
class Croupier::TestFramework::TestCroupier
  def self.instance
    @croupier ||= Croupier::GameRunner.new
  end

  def self.new_instance
    @croupier = Croupier::GameRunner.new
  end
end