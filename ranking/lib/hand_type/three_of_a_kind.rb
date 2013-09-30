
module HandType
  class ThreeOfAKind < Base

    def handles?
      nOfAKind? 3
    end

    def numberOfKickers
      2
    end

    def rank
      3
    end

    def value
      highestSameValue 3
    end

  end
end
