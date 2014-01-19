$:.push(File.join(File.dirname(__FILE__), '../../common/lib'))

require 'thrift_builder'
require_relative 'player'

ThriftBuilder.server(API::PlayerStrategy::Processor, PlayerStrategy::Handler, ARGV[0] || 9200).serve()