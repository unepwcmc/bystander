require 'bystander/scene'

module Bystander
  def self.scene name, &block
    Bystander::Scene.new(name).tap do |scene|
      scene.instance_eval &block if block_given?
      scenes << scene
    end
  end

  def self.scenes
    @scenes ||= []
  end
end
