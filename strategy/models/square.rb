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
  end
end
