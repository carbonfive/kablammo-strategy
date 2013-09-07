module Aggressive
  def hunt
    x, y = robot.x, robot.y
    return first_possible_move 'nesw' if x == 0
    return first_possible_move 'eswn' if y == @battle.board.height - 1
    return first_possible_move 'swne' if x == @battle.board.width - 1
    return first_possible_move 'wnes' if y == 0
    first_possible_move 'wsen'
  end

  def fire_at!(enemy, compensate = 0)
    direction = robot.direction_to(enemy).round
    skew = direction - robot.rotation
    distance = robot.distance_to(enemy)
    max_distance = Math.sqrt(board.height * board.height + board.width * board.width)
    compensation = ( 10 - ( (10 - 3) * (distance / max_distance) ) ).round
    compensation *= -1 if rand(0..1) == 0
    skew += compensation if compensate > rand
    fire! skew
  end

  def act_aggressively
    #power_up = power_ups.first
    #puts "move_towards! (power_up)" if power_up
    #return move_towards! power_up if power_up

    enemy = opponents.first
    puts "hunt" unless enemy
    return hunt unless enemy
    puts "rest" if my.ammo == 0
    return rest if my.ammo == 0
    puts "move_towards! (obscured)" if obscured? enemy
    return move_towards! enemy if obscured? enemy
    puts "fire_at!" if can_fire_at? enemy
    return fire_at! enemy, 0.75 if can_fire_at? enemy
    puts "aim_at!" unless aiming_at? enemy
    return aim_at! enemy unless aiming_at? enemy
    puts "move_towards! (default)"
    move_towards! enemy
  end
end
