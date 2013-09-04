module Strategy::Model
  class Robot
    include Base

    MAX_AMMO = 5

    attr_accessor :username, :rotation, :ammo, :armor, :turns, :square

    def initialize(parent, args)
      super
      @turns = @turns.map { |t| Turn.new self, t }
      @square = parent
    end

    def ammo_full?
      @ammo == MAX_AMMO
    end

    def dead?
      @armor < 0
    end

    def direction_to(enemy)
      square.direction_to enemy.square
    end

    def distance_to(enemy)
      square.distance_to enemy.square
    end

    def line_of_sight(skew = 0)
      pixels = square.board.line_of_sight(square, @rotation + skew)
      pixels.map { |p| square.board.square_at(p.x, p.y) }
    end

    def line_of_sight_to(enemy)
      pixels = square.board.line_of_sight(square, direction_to(enemy))
      pixels.map { |p| square.board.square_at(p.x, p.y) }
    end

    def to_s
      "Robot[#{username}, rot=#{rotation}, ammo=#{ammo}, armor=#{armor}, turns=#{turns}]"
    end
  end
end
