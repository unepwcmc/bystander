require 'bystander/transports/slack'
require 'bystander/class_methods'
require 'bystander/configuration'

module Bystander
  def self.included base
    base.extend ClassMethods
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
