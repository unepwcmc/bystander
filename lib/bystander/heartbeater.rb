module Bystander
  module Heartbeater
    def self.wrap identifier, configuration
      thread = new_thread configuration
      return_value = yield

      thread.kill
      return_value
    end

    private

    def self.new_thread configuration
      Thread.new do
        while true do
          sleep configuration[:every]

          heartbeat = configuration[:block].call
          heartbeat = heartbeat.split("\n").join("\n  ")
          Bystander.transport.notify(
            "Heartbeat from #{identifier}\n  #{heartbeat}"
          )
        end
      end
    end
  end
end
