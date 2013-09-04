module Strategy
  class Combination < Base

    attr_accessor :chooser

    def next_turn
      strategy = @chooser.call
      strategy.for_use_by self
      strategy.next_turn
    end
  end
end
