module Strategy::Model
  class Robot
    include Base
    include Strategy::Constants

    MAX_AMMO = 5

    attr_accessor :username, :rotation, :ammo, :armor, :turns, :power_ups, :square

    def initialize(parent, args)
      super
      @turns = @turns.map { |t| Turn.new self, t }
      @power_ups = @power_ups.map { |p| PowerUp.new self, p }
      @square = parent
    end

    def x
      square.x
    end

    def y
      square.y
    end

    def ammo_full?
      @ammo == MAX_AMMO
    end

    def dead?
      @armor < 0
    end

    def direction_to(target)
      square.direction_to target
    end

    def distance_to(target)
      square.distance_to target
    end

    def line_of_sight(skew = 0)
      pixels = square.board.line_of_sight(square, @rotation + skew)
      pixels.map { |p| square.board.square_at(p.x, p.y) }
    end

    def line_of_sight_to(target)
      pixels = square.board.line_of_sight(square, direction_to(target))
      pixels.map { |p| square.board.square_at(p.x, p.y) }
    end

    def can_fire_at?(target)
      (rotation - direction_to(target)).abs <= MAX_SKEW
    end

    def square_for(direction)
      direction_x, direction_y = x, y
      direction_y += 1 if direction == NORTH
      direction_y -= 1 if direction == SOUTH
      direction_x += 1 if direction == EAST
      direction_x -= 1 if direction == WEST
      square.board.square_at direction_x, direction_y
    end

    def can_move?(move)
      move_square = square_for move
      move_square and ( move_square.empty? || move_square.power_up? )
    end

    def to_s
      "Robot[#{username}, rot=#{rotation}, ammo=#{ammo}, armor=#{armor}, turns=#{turns}]"
    end
  end
end
