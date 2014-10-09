require 'test_helper'

class TestObject
  include Bystander

  def manbonify an_arg
    "fake return value"
  end

  def self.classest_of_methods
  end
end

class BystanderTest < MiniTest::Test
  def test_notify_notifies_before_and_after_method
    TestObject.notify [:manbonify]
    object = TestObject.new

    Bystander.transport.expects(:notify).with("Calling: TestObject#manbonify([\"yo\"])")
    Bystander.transport.expects(:notify).with("Finished: TestObject#manbonify([\"yo\"])")

    return_value = object.manbonify "yo"
    assert_equal "fake return value", return_value
  end

  def test_notify_notifies_before_and_after_class_method
    TestObject.notify [:classest_of_methods]
    Bystander.transport.expects(:notify).with("Calling: TestObject::classest_of_methods([])")
    Bystander.transport.expects(:notify).with("Finished: TestObject::classest_of_methods([])")
    TestObject.classest_of_methods
  end
end
