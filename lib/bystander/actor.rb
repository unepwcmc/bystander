module Bystander
  class Actor
    attr_accessor :scene, :entity

    def initialize entity, scene=nil
      self.entity = entity
      self.scene = scene
    end

    def include_bystander
      return false if bystander_included?
      entity.include(Bystander)
    end

    def bystander_included?
      entity.include? Bystander
    end

    def add_hook method, type, configuration
      entity.send type, method, configuration
    end
  end
end

