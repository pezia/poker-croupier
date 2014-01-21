$:.push('lib/api')

require_relative 'functions'

number_of_players = (ARGV.length > 0) ? ARGV[0].to_i : 3


sit_and_go "../../log/integration_test.log" do
  for index in 0..1
    register_player('localhost',9200+index)
  end
end

