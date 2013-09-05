module Strategy::Model
  class Board
    include Base

    attr_accessor :width, :height, :squares, :battle

    def initialize(parent, args)
      super

      @squares = @squares.map { |s| Square.new self, s }
      @battle = parent
    end

    def square_at(x, y)
      return nil if x < 0 || x >= @width
      return nil if y < 0 || y >= @height
      @squares[@width * y + x]
    end

    def direction_to(source, dest)
      geometry.direction_to(source, dest)
    end

    def distance_to(source, dest)
      geometry.distance_to(source, dest)
    end

    def line_of_sight(source, degrees)
      los = geometry.line_of_sight source, degrees
      los.map { |p| square_at(p.x, p.y) }
    end

    private

    def geometry
      @geometry ||= Geometry.new(@width, @height)
    end
  end
end
