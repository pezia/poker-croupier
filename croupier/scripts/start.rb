require_relative 'functions'

sit_and_go "../../log/game_#{run_timestamp}.log" do
  register_player 'localhost:9200'
  register_player 'localhost:30303'
  register_player 'http://localhost:8080/php/player_service.php'
end
