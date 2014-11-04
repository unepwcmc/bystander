require 'bystander/transports/dev_null'

module Bystander
  def self.enable_testing!
    self.transport = Bystander::Transports::DevNull
  end
end
