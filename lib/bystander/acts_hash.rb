require 'bystander/act'

module Bystander
  class ActsHash < Hash
    attr_accessor :scene

    def initialize scene
      super(nil)
      self.scene = scene
    end

    def add actor, method, hooks={}
      self["#{actor}_#{method}".to_sym] = Bystander::Act.new(actor, method, hooks)
    end
  end
end
