require 'bystander/actors_hash'
require 'bystander/acts_hash'

module Bystander
  class Scene
    def initialize name=nil
      @name = name
    end

    def actors &block
      @actors ||= Bystander::ActorsHash.new
      @actors.instance_eval &block if block_given?

      @actors
    end

    def acts &block
      @acts ||= Bystander::ActsHash.new
      @acts.instance_eval &block if block_given?

      @acts
    end
  end
end
