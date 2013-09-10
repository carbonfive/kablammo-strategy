class Player
  def self.load_strategy(username)
    strategy_path = File.join(Dir.pwd, 'strategy.rb')
    strategy = Strategy::Base.new username
    strategy.load strategy_path
    strategy
  end # make sure this returns your strategy!
end
