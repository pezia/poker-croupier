
class Croupier::LogHandler::HumanReadable
  def initialize
    @message_generator = Croupier::LogHandler::Messages.new
  end

  def method_missing(method, *args, &block)
    begin
      message = @message_generator.send(method, *args, &block)
      Croupier.logger.info message unless message.nil?
    rescue NoMethodError => error
      super method, *args, &block
    end
  end

  def respond_to? (method, include_private = false)
    return true if @message_generator.respond_to? method, false
    super method, include_private
  end
end
