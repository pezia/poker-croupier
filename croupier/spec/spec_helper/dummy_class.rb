class SpecHelper::DummyClass
  def method_missing(method, *args)

  end

  def respont_to?(method)
    true
  end
end