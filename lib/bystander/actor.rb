Dir[File.join(File.dirname(__FILE__), 'hooks/*')].each(&method(:require))

module Bystander
  class Actor
    attr_accessor :scene, :entity

    def initialize entity, scene=nil
      self.entity = entity
      self.scene = scene
    end

    def add_hook method, type, configuration
      hook_class = Bystander::Util.hook_class(type)
      hook = hook_class.new self

      hook.mount method, configuration
    end
  end
end

