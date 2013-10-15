module Ranking
  module HandType
    class HighCard < Base

      def handles?
        true
      end

      def rank
        0
      end
    end
  end
end
