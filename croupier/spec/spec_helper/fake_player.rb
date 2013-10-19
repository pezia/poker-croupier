class SpecHelper::FakePlayer < SpecHelper::DummyClass
  def should_bet(bet)
    should_receive(:bet_request).and_return(bet)
    should_receive(:withdraw).with(bet)
  end
end
