module Bystander
  module Hooks
    class Base
      NOT_IMPLEMENTED_MSG = 'Override this method to have a mountable hook'
      attr_accessor :actor

      def initialize actor
        self.actor = actor
      end

      def mount method_sym, *opts
        raise NotImplementedError, NOT_IMPLEMENTED_MSG
      end

      protected

      def wrap_method method_sym, *opts
        method = Bystander::Util.identify_method(actor.entity, method_sym)

        if method.is_a? UnboundMethod
          wrap_instance_method method, *opts
        else
          wrap_class_method method, *opts
        end
      end

      def instance_method_identifier method
        lambda { |args|
          Bystander::Util.instance_method_identifier(actor.entity, method, args)
        }
      end

      def class_method_identifier method
        lambda { |args|
          Bystander::Util.class_method_identifier(actor.entity, method, args)
        }
      end
    end
  end
end
