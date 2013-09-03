module Strategy
  class Strategy < Combination
    def initialize
      super do
        Combination.new do
          rand() <= 0.5 ? Aggressive.new : Defensive.new
        end
      end
    end
  end
end
