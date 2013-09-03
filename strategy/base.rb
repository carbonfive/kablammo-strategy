module Strategy

  MAX_SKEW = 10

  class Base
    attr_reader :username, :battle

    def execute_turn(username, battle)
      @username = username
      @battle = battle
      next_turn
    end

    def for_use_by(strategy)
      @username = strategy.username
      @battle = strategy.battle
      self
    end

    def robot
      battle.robots.find { |r| r.username == @username }
    end

    def square
      robot.square
    end

    def board
      battle.board
    end

    def find_enemies
      battle.robots.reject {|t| t == robot}.reject {|t| t.dead?}
    end

    def pointed_at?(enemy)
      robot.line_of_sight.include?(enemy)
    end

    def obscured?(enemy)
      los = robot.line_of_sight_to enemy
      hit = los.find { |s| ! s.empty? }
      los.include?(enemy.square) && hit != enemy.square
    end

    def can_fire_at?(enemy)
      (robot.rotation - robot.direction_to(enemy)).abs <= MAX_SKEW
    end

    def can_fire_at_me?(enemy)
      (enemy.rotation - enemy.direction_to(robot)).abs <= MAX_SKEW
    end

    def fire_at(enemy, compensate = 0)
      direction = robot.direction_to(enemy).round
      skew = direction - robot.rotation
      distance = robot.distance_to(enemy)
      max_distance = Math.sqrt(board.height * board.height + board.width * board.width)
      compensation = ( 10 - ( (10 - 3) * (distance / max_distance) ) ).round
      #puts "10 - (10 - 3) * (#{distance} / #{max_distance}) = #{compensation}"
      compensation *= -1 if rand(0..1) == 0
      skew += compensation if compensate > rand
      "f#{skew}"
    end

    def point_at(enemy)
      degrees = robot.direction_to(enemy).round
      "r#{degrees}"
    end

    def approach(enemy)
      aggressive_moves(enemy).find { |m| can_move? m }
    end

    def retreat_from(enemy)
      aggressive_moves(enemy).reverse.find { |m| can_move? m }
    end

    def dodge(enemy)
      am = aggressive_moves enemy
      moves = [ am[1], am[2], am[3], am[4] ]
      moves.find { |m| can_move? m }
    end

    def aggressive_moves(enemy)
      degrees = robot.direction_to(enemy)
      return %w(e n s w) if degrees >= 0   && degrees <= 45
      return %w(n e w s) if degrees >= 45  && degrees <= 90
      return %w(n w e s) if degrees >= 90  && degrees <= 135
      return %w(w n s e) if degrees >= 135 && degrees <= 180
      return %w(w s n e) if degrees >= 180 && degrees <= 225
      return %w(s w e n) if degrees >= 225 && degrees <= 270
      return %w(s e w n) if degrees >= 270 && degrees <= 315
      return %w(e s n w) if degrees >= 315 && degrees <= 360
      throw "unknown direction: #{degrees}"
    end

    def square_for(move)
      x, y = robot.square.x, robot.square.y
      y += 1 if move == 'n'
      y -= 1 if move == 's'
      x += 1 if move == 'e'
      x -= 1 if move == 'w'
      board.square_at x, y
    end

    def can_move?(move)
      next_square = square_for move
      next_square && next_square.empty?
    end

    def rest
      '.'
    end

    def next_turn
      throw 'not implemented'
    end
  end
end
