module Bystander
  module Transports
    module DevNull
      def self.notify message
        # `echo #{message} > /dev/null`
      end

      def self.configure
        yield self
      end
    end
  end
end

