require 'bystander/util/string_extension'

module Bystander
  class ActorsHash < Hash
    def add actor, as=nil
      as ||= actor.name.underscore

      self[as] = actor
    end
  end
end
