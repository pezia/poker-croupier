class SpecHelper::FakeStrategy < SpecHelper::DummyClass
  def should_bet(bet)
    should_receive(:bet_request).and_return(bet)
  end
end
