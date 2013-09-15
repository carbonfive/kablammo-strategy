module Strategy::Model
  class Battle
    include Base

    attr_accessor :name, :turn

    def initialize(args)
      super nil, args
      @turn = Turn.new self, @turn
    end

    def board
      turn.board
    end

    def robots
      board.robots
    end

    def power_ups
      board.power_ups
    end
  end
end
