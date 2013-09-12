module Strategy::Model
  class Robot
    include Base
    include Target
    include Strategy::Constants

    attr_accessor :last_turn, :username, :x, :y, :armor, :ammo, :rotation, :direction, :abilities, :power_ups, :board

    def initialize(parent, args)
      super
      @power_ups = @power_ups.map { |p| PowerUp.new self, p }
      @board = parent
    end

    def ammo_full?
      ammo == MAX_AMMO
    end

    def dead?
      armor < 0
    end

    def direction_to(target)
      board.direction_to self, target
    end

    def distance_to(target)
      board.distance_to self, target
    end

    def line_of_sight(skew = 0)
      board.line_of_sight(self, rotation + skew).map {|p| Pixel.new p}
    end

    def line_of_sight_to(target)
      board.line_of_sight(self, direction_to(target)).map {|p| Pixel.new p}
    end

    def can_fire_at?(target)
      (rotation - direction_to(target)).abs <= MAX_SKEW
    end

    def can_see?(target)
      los = line_of_sight_to target
      hit = los.detect { |p| board.obstruction? p }
      val = target.located_at? hit
      val
    end

    def target_for(direction)
      direction_x, direction_y = x, y
      direction_y += 1 if direction == NORTH
      direction_y -= 1 if direction == SOUTH
      direction_x += 1 if direction == EAST
      direction_x -= 1 if direction == WEST
      Pixel.new Struct.new(:x, :y).new(direction_x, direction_y)
    end

    def can_move?(move)
      board.available? target_for(move)
    end

    def to_s
      "Robot[#{username}, x=#{x}, y=#{y}, ammo=#{ammo}, armor=#{armor}, rotation=#{rotation}, direction=#{direction}]"
    end
  end
end
