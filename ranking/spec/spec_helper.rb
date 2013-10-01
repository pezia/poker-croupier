module Helpers
  def hand(*args)
    Hand.new(*args)
  end
end

require 'rspec'
include Helpers

require_relative '../lib/hand'


class Hand
  
  def should_defeat otherHand
    self.defeats?(otherHand).should == true
    otherHand.defeats?(self).should == false
  end

  def should_tie_with otherHand
    self.defeats?(otherHand).should == false
    otherHand.defeats?(self).should == false
  end

end

