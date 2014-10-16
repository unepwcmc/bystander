require 'test_helper'

class TestObject < Object; end;

class HooksNotifyTest < MiniTest::Test
  def test_notify_notifies_before_and_after_method
    TestObject.class_eval do
      include Bystander::Hooks::Notify
      define_method(:manbonify) {|an_arg| "fake return value" }

      notify :manbonify
    end

    object = TestObject.new

    Bystander.transport.expects(:notify).with("Calling: TestObject#manbonify(yo)")
    Bystander.transport.expects(:notify).with("Finished: TestObject#manbonify(yo)")

    return_value = object.manbonify "yo"
    assert_equal "fake return value", return_value
  end

  def test_notify_notifies_before_and_after_class_method
    TestObject.class_eval do
      include Bystander::Hooks::Notify
      define_singleton_method(:classest_of_methods){}

      notify :classest_of_methods
    end

    Bystander.transport.expects(:notify).with("Calling: TestObject::classest_of_methods()")
    Bystander.transport.expects(:notify).with("Finished: TestObject::classest_of_methods()")
    TestObject.classest_of_methods
  end
end
