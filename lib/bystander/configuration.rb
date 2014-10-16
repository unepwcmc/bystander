require 'bystander/scene'

module Bystander
  def self.scene name, &block
    scene = Bystander::Scene.new(name)

    include_scene(scene, &block) if block_given?
    scenes << scene

    scene
  end

  def self.scenes
    @scenes ||= []
  end

  def self.actors
    @actors ||= Bystander::ActorsHash.new
  end

  def self.acts
    @acts ||= Bystander::ActsHash.new
  end

  private

  def self.include_scene scene, &block
    scene.instance_eval &block
    scene_prefix = -> (name) { "#{scene.name}__#{name}".to_sym }

    scene.actors.each do |name, actor|
      actors[scene_prefix.call(name)] = actor
    end
    scene.acts.each do |name, act|
      acts[scene_prefix.call(name)] = act
    end

    scene.load_hooks
  end
end
