require 'bystander/notifier'

module Bystander
  module Hooks
    module Notify
      def self.included base
        base.extend ClassMethods
      end
    end
  end
end

module Bystander::Hooks::Notify::ClassMethods
  def notify method_sym, configuration={}
    method = Bystander::Util.identify_method(self, method_sym)

    if method.is_a? UnboundMethod
      wrap_instance_method method
    else
      wrap_class_method method
    end
  end

  private

  def wrap_instance_method method
    define_method(method.name) do |*args, &block|
      identifier = Bystander::Util.instance_method_identifier(
        self, method, args
      )

      Bystander::Notifier.wrap(identifier) do
        method.bind(self).call(*args, &block)
      end
    end
  end

  def wrap_class_method method
    define_singleton_method(method.name) do |*args, &block|
      identifier = Bystander::Util.class_method_identifier(
        self, method, args
      )

      Bystander::Notifier.wrap(identifier) do
        method.call(*args, &block)
      end
    end
  end
end
