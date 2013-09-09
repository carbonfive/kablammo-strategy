module Strategy::Model
  class Turn
    include Base
    include Target

    attr_accessor :value, :rotation, :ammo, :armor, :abilities, :robot

    def initialize(parent, args)
      super
      @robot = parent
    end

    def to_s
      @value
    end
  end
end
