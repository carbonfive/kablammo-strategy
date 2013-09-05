module Strategy::Model
  class Battle
    include Base

    attr_accessor :name, :board

    def initialize(args)
      super nil, args
      @board = Board.new self, @board
    end

    def robots
      @board.squares.select {|s| s.robot?}.map {|s| s.robot}
    end
  end
end
