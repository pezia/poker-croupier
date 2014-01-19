class Croupier::LogHandler::MultiLogger
  def initialize(*loggers)
    @loggers = loggers
  end

  def method_missing(method, *args, &block)
    begin
      @loggers.each do |logger|
        logger.send(method, *args, &block)
      end
    rescue NoMethodError => error
      super method, *args, &block
    end
  end

  def respond_to? (method, include_private = false)
    return true if (instance_variable_get "@#{member}").respond_to? method, false
    super method, include_private
  end
end