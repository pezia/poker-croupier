def delegate_all(member)
  define_method :method_missing do |method, *args, &block|
    begin
      (instance_variable_get "@#{member}").send(method, *args, &block)
    rescue NoMethodError => error
      super method, *args, &block
    end
  end

  define_method :respond_to? do |method, include_private = false|
    return true if (instance_variable_get "@#{member}").respond_to? method, false
    super method, include_private
  end

end