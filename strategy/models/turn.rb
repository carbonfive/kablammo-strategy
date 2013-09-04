module Strategy::Model
  class Turn
    include Base

    attr_accessor :value, :robot

    def initialize(parent, args)
      super
      @robot = parent
    end

    def to_s
      @value
    end
  end
end
