module Bystander
  module Ensurer
    def self.wrap identifier, ensure_block
      return_value = yield

      return_value.tap{ |value|
        success = ensure_block.call(return_value)
        Bystander.transport.notify "Ensure failed: #{identifier}" unless success
      }
    end
  end
end
