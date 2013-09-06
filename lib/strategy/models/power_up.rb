module Strategy::Model
  class PowerUp
    include Base

    attr_accessor :name, :duration, :type, :abilities

    def initialize(parent, args)
      super
      @parent = parent
    end

    def x
      @parent.x
    end

    def y
      @parent.y
    end

    def to_s
      "PowerUp[#{name}, #{duration}]"
    end
  end
end
