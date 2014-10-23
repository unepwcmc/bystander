module Bystander
  module Notifier

    def self.wrap identifier
      Bystander.transport.notify "Calling: #{identifier}"
      return_value = yield
      Bystander.transport.notify "Finished: #{identifier}"

      return_value
    end

    def self.before identifier
      Bystander.transport.notify "Calling: #{identifier}"
      yield
    end

    def self.after identifier
      return_value = yield
      Bystander.transport.notify "Finished: #{identifier}"

      return_value
    end
  end
end
