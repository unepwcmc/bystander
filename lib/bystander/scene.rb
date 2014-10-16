require 'bystander/actors_hash'
require 'bystander/acts_hash'

module Bystander
  class Scene
    attr_accessor :name
    def initialize name=nil
      self.name = name
    end

    def actors &block
      @actors ||= Bystander::ActorsHash.new self
      @actors.instance_eval &block if block_given?

      @actors
    end

    def acts &block
      @acts ||= Bystander::ActsHash.new self
      @acts.instance_eval &block if block_given?

      @acts
    end

    def load_hooks
      acts.values.each(&:load_hooks)
    end
  end
end
