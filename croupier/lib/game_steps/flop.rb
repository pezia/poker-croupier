class Croupier::GameSteps::Flop < Croupier::GameSteps::Base
  def run
    3.times do
      Croupier::GameSteps::DealCommunityCard.new(game_state).run
    end
  end

end
