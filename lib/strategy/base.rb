module Strategy
  class Base
    include Constants

    attr_reader :username, :battle

    def initialize(username)
      @username = username
    end

    def load(strategy_path)
      code = IO.read strategy_path
      instance_eval(code, strategy_path)
    end

    def on_turn(&block)
      @on_turn_block = block
    end

    def next_turn
      @on_turn_block.call
    end

    def execute_turn(battle)
      @battle = battle
      next_turn
    end

    def visible_players
      battle.robots.reject{|r| r.dead? }
    end

    def opponents
      visible_players.reject{ |r| r == me }
    end

    def power_ups
      battle.power_ups
    end

    def for_use_by(strategy)
      @username = strategy.username
      @battle = strategy.battle
      self
    end

    def robot
      battle.robots.find { |r| r.username == @username }
    end

    def board
      battle.board
    end

    def fire(skew=0)
      "f#{skew}"
    end

    def fire!(skew=0)
      fire skew
    end

    def rotate(degrees)
      unless degrees
        raise 'Rotate issued with unspecified number of degrees'
      end
      "r#{degrees}"
    end

    def rotate!(degrees)
      rotate degrees
    end

    def move!(direction)
      direction
    end

    def move_north!
      move! NORTH
    end

    def move_south!
      move! SOUTH
    end

    def move_east!
      move! EAST
    end

    def move_west!
      move! WEST
    end

    def aiming_at?(target)
      robot.line_of_sight.any? { |p| p.located_at? target }
    end

    def aim_at!(target)
      rotate! robot.direction_to(target).round
    end

    def rest
      '.'
    end

    def can_move?(move)
      i.can_move? move
    end

    def can_fire_at?(target)
      i.can_fire_at? target
    end

    def move_towards!(target)
      move! first_possible_move moves_toward(target)
    end

    def move_away_from!(target)
      move! first_possible_move moves_toward(target).reverse
    end

    def obscured?(target)
      ! i.can_see? target
    end

    def moves_toward(target)
      degrees = robot.direction_to(target)
      return [EAST, NORTH, SOUTH, WEST] if degrees >= 0   && degrees <= 45
      return [NORTH, EAST, WEST, SOUTH] if degrees >= 45  && degrees <= 90
      return [NORTH, WEST, EAST, SOUTH] if degrees >= 90  && degrees <= 135
      return [WEST, NORTH, SOUTH, EAST] if degrees >= 135 && degrees <= 180
      return [WEST, SOUTH, NORTH, EAST] if degrees >= 180 && degrees <= 225
      return [SOUTH, WEST, EAST, NORTH] if degrees >= 225 && degrees <= 270
      return [SOUTH, EAST, WEST, NORTH] if degrees >= 270 && degrees <= 315
      return [EAST, SOUTH, NORTH, WEST] if degrees >= 315 && degrees <= 360
      throw "unknown direction: #{degrees}"
    end

    def first_possible_move(moves)
      case moves
      when Array
        moves
      else
        moves.split ''
      end.find { |m| can_move? m }
    end

    alias_method :me, :robot
    alias_method :i, :robot
    alias_method :my, :robot
  end
end
