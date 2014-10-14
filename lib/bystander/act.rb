module Bystander
  class Act
    attr_accessor :actor, :method, :hooks

    def initialize actor, method, hooks={}
      self.actor = actor
      self.method = method
      self.hooks = hooks
    end

  end
end
