module Bystander
  module Hooks
    module Heartbeat
      def self.included base
        base.extend ClassMethods
      end
    end
  end
end

module Bystander::Hooks::Heartbeat::ClassMethods
  def heartbeat method_sym, configuration={}
  end

  private
end

