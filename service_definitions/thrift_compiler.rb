
require 'fileutils'

def compile_module( dir, gen, service )
    path = dir+'/lib/api/'
    FileUtils.mkpath path
    cmd = 'thrift -out '+path+' -gen '+gen+' ./service_definitions/'+service+'.thrift'
    system(cmd)
end

Dir.glob('./service_definitions/*.thrift') do |thrift_file|
    thrift_service = File.basename(thrift_file).split('.').first
    if thrift_service == 'player_strategy'
        Dir.glob('player/*') do |player_service|
            gen = player_service.split('/').last
            compile_module(player_service, gen, 'player_strategy')
        end
    else
        compile_module(thrift_service, 'rb', thrift_service)
    end    
end
