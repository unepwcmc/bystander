module Bystander
  module Hooks
    module Heartbeat
      def self.included base
        base.extend ClassMethods
      end

      def self.start identifier, configuration
        Thread.new{
          while true do
            sleep configuration[:every]
            Bystander.transport.notify(
              "``\nHeartbeat from #{identifier} \n>  #{configuration[:block].call}``"
            )
          end
        }
      end
    end
  end
end

module Bystander::Hooks::Heartbeat::ClassMethods
  def heartbeat method_sym, configuration={}
    method = Bystander::Util.identify_method(self, method_sym)

    if method.is_a? UnboundMethod
      wrap_instance_method method, configuration
    else
      wrap_class_method method, configuration
    end
  end

  private

  def wrap_instance_method method, configuration
    define_method(method.name) do |*args, &block|
      identifier = Bystander::Util.instance_method_identifier(
        self, method, args
      )
      thread = Bystander::Hooks::Heartbeat.start(identifier, configuration)
      return_value = method.bind(self).call(*args, &block)

      thread.kill
      return_value
    end
  end

  def wrap_class_method method, configuration
    define_singleton_method(method.name) do |*args, &block|
      identifier = Bystander::Util.class_method_identifier(
        self, method, args
      )
      thread = Bystander::Hooks::Heartbeat.start(identifier, configuration)
      return_value = method.call(*args, &block)

      thread.kill
      return_value
    end
  end
end
