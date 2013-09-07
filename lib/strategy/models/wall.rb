module Strategy::Model
  class Wall
    include Base
    include Target

    attr_accessor :board

    def initialize(parent, args)
      super
      @board = parent
    end

    def to_s
      "Wall[#{x}, #{y}]"
    end
  end
end
