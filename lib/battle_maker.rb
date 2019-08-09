require "kablammo"

# Generates battles, with a set of walls and players
# Used for testing specific scenarios.

module BattleMaker

  # Creates a new Battle object
  # @param map [Array<String>] One string represents a row of cells. Options:
  #  x: wall
  #  0-9: robot (0 represents your player)
  #  space or _: empty cell
  # @param robot_overrides [Hash{number => Hash}]
  #  you can override values for any robot. Keys correspond to the robot numbers in the map.
  # @returns Strategy::Model::Battle

  def self.make(map, robot_overrides = {})
    width = map[0].length
    height = map.length

    walls = map_to_walls(map)
    robots = map_to_robots(map)

    # For each robot, add in overrides for that bot.
    robots = robots.map.with_index do |robot, i|
      robot.merge(robot_overrides[i] || {})
    end

    battle = make_battle(
      width: width,
      height: height,
      walls: walls,
      robots: robots,
    )

    # Filter out invisible opponents
    player = battle.robots[0]
    battle.robots.filter! do |robot|
      if robot == player
        true
      else
        player.can_see?(robot)
      end
    end

    battle
  end

  class << self
    private

    def self.map_to_walls(map)
      walls = []

      each_cell(map) do |cell, x, y|
        next unless cell == "x"
        walls.push({ x: x, y: y })
      end

      walls
    end

    def self.map_to_robots(map)
      robots = []
      each_cell(map) do |cell, x, y|
        next unless cell =~ /[0-9]/

        robots.push({
          username: "robot_#{cell}",
          x: x,
          y: y,
        })
      end

      robots.sort_by { |robot| robot[:username] }
    end

    def self.each_cell(map, &block)
      map.reverse.each_with_index do |row, y|
        row.chars.to_a.each_with_index do |cell, x|
          block.call(cell, x, y)
        end
      end
    end

    def self.make_battle(
                         width: 5,
                         height: 5,
                         walls:,
                         robots:)
      default_robot = {
        username: "robot",
        last_turn: "*",
        x: 0,
        y: 0,
        armor: 5,
        ammo: 10,
        rotation: 0,
        direction: 0,
        abilities: [],
        power_ups: [],
      }

      Strategy::Model::Battle.new(
        turn: {
          board: {
            width: width,
            height: height,
            walls: walls,
            robots: robots.map { |robot| default_robot.merge(robot) },
            power_ups: [],
          },
        },
      )
    end
  end
end
