module Observer
  module Notifier

    def self.wrap identifier
      Observer.transport.notify "Calling: #{identifier}"
      return_value = yield
      Observer.transport.notify "Finished: #{identifier}"

      return_value
    end

  end
end
