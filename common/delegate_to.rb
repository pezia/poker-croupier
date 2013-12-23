def delegate_to(member)
  define_method :method_missing do |method, *args, &block|
    (instance_variable_get "@#{member}").send(method, *args, &block)
  end
end