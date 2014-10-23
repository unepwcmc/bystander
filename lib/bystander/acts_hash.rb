require 'bystander/act'

module Bystander
  class ActsHash < Hash
    attr_accessor :scene

    def initialize scene=nil
      super(nil)
      self.scene = scene
    end

    def add actor, method, hooks={}
      self["#{actor}__#{method}".to_sym] = Bystander::Act.new(
        scene.actors[actor], method, hooks
      )
    end
  end
end
