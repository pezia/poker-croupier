
require 'fileutils'

def compile_module( dir, gen, service, subdir = '/lib/api/' )
    path = dir+subdir
    FileUtils.mkpath path
    cmd = 'thrift -out '+path+' -gen '+gen+' ./service_definitions/'+service+'.thrift'
    system(cmd)
end

def compile_clients(language, subdir = '/lib/api/')
  compile_module "player/#{language}", language, 'player_strategy', subdir
  compile_module "player/#{language}", language, 'ranking', subdir
  compile_module "player/#{language}", language, 'types', subdir
end

compile_module 'croupier', 'rb', 'croupier'
compile_module 'croupier', 'rb', 'player_strategy'
compile_module 'croupier', 'rb', 'spectator'
compile_module 'croupier', 'rb', 'types'
compile_module 'ranking', 'rb', 'ranking'
compile_module 'ranking', 'rb', 'types'

compile_clients 'cpp'
compile_clients 'csharp'
compile_clients 'erl'
compile_clients 'java', '/src/main/java/'
compile_module 'player/php', 'php:server', 'player_strategy'
compile_module 'player/php', 'php', 'ranking'
compile_module 'player/php', 'php', 'types'
compile_clients 'py'
compile_clients 'rb'
