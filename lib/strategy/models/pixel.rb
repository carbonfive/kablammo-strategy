module Strategy::Model
  class Pixel
    include Target

    def initialize(p)
      @x = p.x
      @y = p.y
    end

    def to_s
      "[#{x}, #{y}]"
    end
  end
end
