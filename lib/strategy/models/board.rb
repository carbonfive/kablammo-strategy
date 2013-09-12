module Strategy::Model
  class Board
    include Base

    attr_accessor :width, :height, :robots, :walls, :power_ups, :turn

    def initialize(parent, args)
      super

      @robots = @robots.map { |r| Robot.new self, r }
      @walls = @walls.map { |w| Wall.new self, w }
      @power_ups = @power_ups.map { |p| PowerUp.new self, p }
      @turn = parent
    end

    def in_bounds?(target)
      return false if target.x < 0 || target.x >= width
      return false if target.y < 0 || target.y >= height
      true
    end

    def available?(target)
      return false unless in_bounds? target
      walls.none? { |w| w.located_at? target } && robots.none? { |r| r.located_at? target }
    end

    def obstruction?(target)
      walls.any? { |w| w.located_at? target } || robots.any? { |r| r.located_at? target }
    end

    def direction_to(source, dest)
      geometry.direction_to(source, dest)
    end

    def distance_to(source, dest)
      geometry.distance_to(source, dest)
    end

    def line_of_sight(source, degrees)
      geometry.line_of_sight(source, degrees).map {|p| Pixel.new p}
    end

    private

    def geometry
      @geometry ||= Geometry.new(@width, @height)
    end
  end
end
