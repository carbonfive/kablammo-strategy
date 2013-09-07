module Strategy::Model
  class Battle
    include Base

    attr_accessor :name, :board

    def initialize(args)
      super nil, args
      @board = Board.new self, @board
    end

    def robots
      @board.robots
    end

    def power_ups
      @board.power_ups
    end
  end
end
