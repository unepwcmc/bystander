require 'bystander/hooks/base'
require 'bystander/heartbeater'

module Bystander
  module Hooks
    class Heartbeat < Bystander::Hooks::Base

      def mount method_sym, configuration={every: 60, block: -> {}}
        wrap_method(method_sym, configuration)
      end

      protected

      def wrap_instance_method method, configuration
        method_identifier = instance_method_identifier(method)

        actor.entity.send(:define_method, method.name) do |*args, &block|
          Bystander::Heartbeater.wrap(method_identifier.call(args), configuration) {
            method.bind(self).call(*args, &block)
          }
        end
      end

      def wrap_class_method method, configuration
        method_identifier = class_method_identifier(method)

        actor.entity.send(:define_singleton_method, method.name) do |*args, &block|
          Bystander::Heartbeater.wrap(method_identifier.call(args), configuration) {
            method.call(*args, &block)
          }
        end
      end
    end
  end
end
