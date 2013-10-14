$:.push(File.join(File.dirname(__FILE__), '../common/lib'))

require 'thrift_builder'
require_relative 'croupier'

ThriftBuilder.server(API::Croupier::Processor, Croupier::Handler, 9090).serve()

