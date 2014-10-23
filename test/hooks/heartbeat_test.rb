require 'test_helper'

class TestObject < Object; end;

class HooksHeartbeatTest < MiniTest::Test
  def test_mount_notifies_with_heartbeats_during_instance_methods
    skip

    TestObject.class_eval { define_method(:manbonify){|an_arg| sleep 3; 'fake return value'} }

    actor = Bystander::Actor.new(TestObject)
    heartbeat = Bystander::Hooks::Heartbeat.new(actor)
    heartbeat.mount(:manbonify, {every: 1, block: -> { 'a message' }})

    Bystander.transport.expects(:notify)

    object = TestObject.new
    assert_equal 'fake return value', object.manbonify('yo')
  end
end

