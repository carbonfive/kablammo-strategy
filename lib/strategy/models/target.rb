module Strategy::Model
  module Target
    attr_accessor :x, :y

    def located_at?(target)
      x == target.x && y == target.y
    end
  end
end
