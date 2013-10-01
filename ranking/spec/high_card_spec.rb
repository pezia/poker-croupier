require_relative "spec_helper"

describe "High Card" do

  it 'should be comparable when both are high card' do
    hand('10 of Hearts', '7 of Diamonds').
        should_defeat hand('8 of Clubs', '7 of Diamonds')
  end

end


