require 'test_helper'

class TestObject < Object; end;

class BystanderTest < MiniTest::Test
  def test_log_notifies_the_transport_with_given_message
    message = 'I just logged something'
    Bystander.transport.expects(:notify).with(message)

    Bystander.log message
  end
end
