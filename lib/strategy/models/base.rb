module Strategy
  module Model
    module Base
      def initialize(parent, args)
        args.each do |k, v|
          method = "#{k}="
          send method, v if respond_to?(method.to_sym)
        end
      end
    end
  end
end
