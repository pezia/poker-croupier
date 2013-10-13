
require 'fileutils'

def compile_module( dir, gen, service )
    path = dir+'/lib/api/'
    FileUtils.mkpath path
    cmd = 'thrift -out '+path+' -gen '+gen+' ./service_definitions/'+service+'.thrift'
    system(cmd)
end

compile_module('croupier', 'rb', 'croupier')
compile_module('croupier', 'rb', 'player_strategy')
compile_module('croupier', 'rb', 'spectator')
compile_module('croupier', 'rb', 'types')
compile_module('player/php', 'php', 'player_strategy')
compile_module('player/php', 'php', 'types')
compile_module('player/rb', 'rb', 'player_strategy')
compile_module('player/rb', 'rb', 'types')

