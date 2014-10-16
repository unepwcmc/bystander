Dir[File.join(File.dirname(__FILE__), 'hooks/*')].each(&method(:require))

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
      hook_class = Bystander::Util.classify_string(type.to_s)

      entity.include Kernel.const_get("Bystander::Hooks::#{hook_class}")
      entity.send type, method, configuration
    end
  end
end

