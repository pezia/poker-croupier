require_relative 'functions'

sit_and_go 'game.log' do
  register_player 'localhost', 9200
  register_player 'localhost', 9201
end
