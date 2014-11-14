require 'bystander/transports/dev_null'

module Bystander
  def self.enable_testing!
    @testing = true
    self.transport = Bystander::Transports::DevNull
  end

  def self.testing?
    !!@testing
  end
end
