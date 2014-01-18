$:.push('../lib/api')

require_relative 'start/functions'

start_server 'game.log'
client = connect_server

client.register_player 'localhost', 9200
client.register_player 'localhost', 9201

client.start_sit_and_go()