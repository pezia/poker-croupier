
module HandType
  class FourOfAKind < Base

    def handles?
      nOfAKind? 4
    end

    def numberOfKickers
      1
    end

    def rank
      7
    end

    def value
      highestSameValue 4
    end

    #because the kicker could be part of a pair
    def kickers
      [[super,highestSameValueExcept(2,value)].flatten.max]
    end

  end
end
