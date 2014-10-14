require 'bystander/util'

module Bystander
  class ActorsHash < Hash
    def add actor, as=nil
      as ||= Bystander::Util.snakecase_string(actor.name)

      self[as] = actor
    end
  end
end
