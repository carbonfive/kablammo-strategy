module Strategy::Model
  class Square
    include Base

    attr_accessor :x, :y, :state, :robot, :board

    def initialize(parent, args)
      super

      @state ||= 'empty'
      @robot = Robot.new self, @robot if @robot
      @board = parent
    end

    def empty?
      @state == 'empty'
    end

    def wall?
      @state == 'wall'
    end

    def robot?
      @state == 'robot'
    end

    def obscured?
      @state == 'obscured'
    end

    def distance_to(square)
      return 0 unless square
      @board.distance_to(self, square)
    end

    def direction_to(square)
      return 0 unless square
      @board.direction_to(self, square)
    end

    def to_s
      "Square[#{x}, #{y}, #{state}]"
    end
  end
end
