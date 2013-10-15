$:.push(File.join(File.dirname(__FILE__), '../common/lib'))

require 'thrift_builder'
require_relative 'logging_spectator'

ThriftBuilder.server(API::Spectator::Processor, LoggingSpectator::Handler, ARGV.first).serve()