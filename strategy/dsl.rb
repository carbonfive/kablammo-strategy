module Strategy
  class DSL < Base
    def load(strategy_path)
      code = IO.read strategy_path
      instance_eval(code, strategy_path)
    end

    def on_startup(&block)
      instance_eval(&block)
    end

    def on_turn(&block)
      @on_turn_block = block
    end

    def next_turn
      @on_turn_block.call
    end
  end
end
