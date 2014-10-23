require 'bystander/hooks/base'
require 'bystander/ensurer'

module Bystander
  module Hooks
    class Ensure < Bystander::Hooks::Base

      def mount method_sym, ensure_block
        wrap_method(method_sym, ensure_block)
      end

      protected

      def wrap_instance_method method, ensure_block
        method_identifier = instance_method_identifier(method)

        actor.entity.send(:define_method, method.name) do |*args, &block|
          Bystander::Ensurer.wrap(method_identifier.call(args), ensure_block) {
            method.bind(self).call(*args, &block)
          }
        end
      end

      def wrap_class_method method, ensure_block
        method_identifier = class_method_identifier(method)

        actor.entity.send(:define_singleton_method, method.name) do |*args, &block|
          Bystander::Ensurer.wrap(method_identifier.call(args), ensure_block) {
            method.call(*args, &block)
          }
        end
      end
    end

  end
end
