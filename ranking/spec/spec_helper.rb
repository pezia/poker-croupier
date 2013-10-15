$:.push(File.join(File.dirname(__FILE__), '../../common/lib'))


module Helpers
  def hand(*cards)
    Ranking::Hand.new(*cards)
  end
end

require 'rspec'
include Helpers

require_relative '../lib/hand'


module Ranking
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
end
