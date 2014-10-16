require 'bystander/actor'
require 'bystander/util'

module Bystander
  class ActorsHash < Hash
    attr_accessor :scene

    def initialize scene=nil
      super(nil)
      self.scene = scene
    end

    def add actor_class, as=nil
      as ||= Bystander::Util.snakecase_string(actor_class.name)

      self[as.to_sym] = Bystander::Actor.new actor_class, scene
    end
  end
end

