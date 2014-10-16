require 'bystander/ensurer'

module Bystander
  module Hooks
    module Ensure
      def self.included base
        base.extend ClassMethods
      end
    end
  end
end

module Bystander::Hooks::Ensure::ClassMethods
  def ensure method_sym, block
    method = Bystander::Util.identify_method(self, method_sym)

    if method.is_a? UnboundMethod
      wrap_instance_method method, block
    else
      wrap_class_method method, block
    end
  end

  private

  def wrap_instance_method method, ensure_block
    define_method(method.name) do |*args, &block|
      method_identifier = Bystander::Util.instance_method_identifier(
        self, method, args
      )

      Bystander::Ensurer.wrap(method_identifier, ensure_block) {
        method.bind(self).call(*args, &block)
      }
    end
  end

  def wrap_class_method method, ensure_block
    define_singleton_method(method.name) do |*args, &block|
      method_identifier = Bystander::Util.class_method_identifier(
        self, method, args
      )

      Bystander::Ensurer.wrap(method_identifier, ensure_block) {
        method.call(*args, &block)
      }
    end
  end
end
