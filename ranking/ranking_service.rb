$:.push(File.join(File.dirname(__FILE__), '../common/lib'))

require 'thrift_builder'
require_relative 'handler'

ThriftBuilder.server(API::Ranking::Processor, Ranking::Handler, 9080).serve()