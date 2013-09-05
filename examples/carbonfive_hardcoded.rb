module Strategy
  class Strategy < Combination
    def initialize(username)
      super

      self.chooser = Proc.new do
        factors = { mwynholds: 0.8, carbonfive: 0.5, dhendee: 0.2 }
        factor = factors[username.to_sym] || 0.5
        rand() <= factor ? Aggressive.new(username) : Defensive.new(username)
      end
    end
  end
end
