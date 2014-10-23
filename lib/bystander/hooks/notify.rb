require 'bystander/hooks/base'
require 'bystander/notifier'

module Bystander
  module Hooks
    class Notify < Bystander::Hooks::Base

      def mount method_sym, type=:wrap
        wrap_method(method_sym, type)
      end

      private

      def wrap_instance_method method, type
        notifier = Bystander::Notifier.method(type)
        method_identifier = instance_method_identifier(method)

        actor.entity.send(:define_method, method.name) do |*args, &block|
          notifier.call(method_identifier.call(args)) do
            method.bind(self).call(*args, &block)
          end
        end
      end

      def wrap_class_method method, type
        notifier = Bystander::Notifier.method(type)
        method_identifier = class_method_identifier(method)

        actor.entity.send(:define_singleton_method, method.name) do |*args, &block|
          notifier.call(method_identifier.call(args)) do
            method.call(*args, &block)
          end
        end
      end
    end
  end
end
