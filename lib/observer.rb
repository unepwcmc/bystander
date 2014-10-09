require 'observer/notifier'
require 'observer/transports/slack'

module Observer
  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods
    def notify methods
      methods.each{ |method| wrap_method(method) }
    end

    private

    def wrap_method method_name
      original_method = method(method_name) rescue instance_method(method_name)

      if original_method.is_a? UnboundMethod
        wrap_instance_method original_method
      else
        wrap_class_method original_method
      end
    end

    def wrap_instance_method method
      define_method(method.name) do |*args, &block|
        Observer::Notifier.wrap("#{self.class.to_s}##{method.name}(#{args.inspect})") do
          method.bind(self).call(*args, &block)
        end
      end
    end

    def wrap_class_method method
      define_singleton_method(method.name) do |*args, &block|
        Observer::Notifier.wrap("#{self.to_s}::#{method.name}(#{args.inspect})") do
          method.call(*args, &block)
        end
      end
    end
  end

  def self.transport
    @transport ||= Observer::Transports::Slack
  end

  def self.transport= transport
    @transport = transport
  end
end
