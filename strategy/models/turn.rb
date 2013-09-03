module Strategy::Model
  class Turn
    include Base

    attr_accessor :value, :robot

    def initialize(parent, args)
      @robot = parent
    end
  end
end
