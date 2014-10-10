require 'bystander/notifier'
require 'bystander/util/testing'

module Bystander
  module ClassMethods
    @@methods_to_notify = []
    @@redefined_methods = []

    def notify methods
      @@methods_to_notify = methods
    end

    def method_added method
      if notify?(method) && !redefined?(method)
        @@redefined_methods << method
        wrap_instance_method instance_method(method)
      end
    end

    def singleton_method_added method
      if notify?(method) && !redefined?(method)
        @@redefined_methods << method
        wrap_class_method method(method)
      end
    end

    private

    def notify? method
      @@methods_to_notify.include? method
    end

    def redefined? method
      @@redefined_methods.include? method
    end

    def wrap_instance_method method
      define_method(method.name) do |*args, &block|
        Bystander::Notifier.wrap("#{self.class.to_s}##{method.name}(#{args.join(', ')})") do
          method.bind(self).call(*args, &block)
        end
      end
    end

    def wrap_class_method method
      define_singleton_method(method.name) do |*args, &block|
        Bystander::Notifier.wrap("#{self.to_s}::#{method.name}(#{args.join(', ')})") do
          method.call(*args, &block)
        end
      end
    end
  end
end
