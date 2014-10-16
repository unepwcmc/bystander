module Bystander
  class Act
    attr_accessor :actor, :method, :hooks

    def initialize actor, method, hooks={}
      self.actor = actor
      self.method = method
      self.hooks = hooks
    end

    def load_hooks
      actor.include_bystander

      hooks.each do |type, configuration|
        actor.add_hook method, type, configuration
      end
    end

  end
end
