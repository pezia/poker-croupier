
class Croupier::TestFramework::TestCroupier
  def self.instance
    @croupier ||= Croupier::Croupier.new
  end

  def self.new_instance
    @croupier = Croupier::Croupier.new
  end
end