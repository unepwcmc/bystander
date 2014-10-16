require 'test_helper'

class EnsurerTest < MiniTest::Test
  def test_wrap_notifies_the_transport_when_ensure_is_not_successful
    identifier = 'Object::method(args)'

    transport_mock = mock
    transport_mock.expects(:notify).with("Ensure failed: #{identifier}")
    Bystander.stubs(:transport).returns(transport_mock)

    Bystander::Ensurer.wrap(identifier, -> (value) { false }) {}
  end
end
