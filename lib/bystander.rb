require 'bystander/transports/slack'
require 'bystander/transports/dev_null'

require 'bystander/configuration'

module Bystander
  class HookNotFoundError < NameError
    def initialize hook_name
      super("Hook '#{hook_name}' not found. Maybe you misspelled it?")
    end
  end

  def self.log message
    transport.notify message
  end

  def self.transport
    @transport ||= Bystander::Transports::Slack
  end

  def self.transport= transport
    @transport = transport
  end
end
