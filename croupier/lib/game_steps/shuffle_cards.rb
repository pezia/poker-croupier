class Croupier::GameSteps::ShuffleCards < Croupier::GameSteps::Base
  def run
    game_state.deck.shuffle
  end
end