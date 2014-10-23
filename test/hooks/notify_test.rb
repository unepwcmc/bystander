require 'test_helper'

class TestObject < Object; end;

class HooksNotifyTest < MiniTest::Test
  def test_mount_wrap_notifies_before_and_after_methods
    TestObject.class_eval { define_method(:manbonify){|an_arg| 'fake return value'} }

    actor = Bystander::Actor.new(TestObject)
    notify = Bystander::Hooks::Notify.new(actor)
    notify.mount(:manbonify, :wrap)

    Bystander.transport.expects(:notify).with('Calling: TestObject#manbonify(yo)')
    Bystander.transport.expects(:notify).with('Finished: TestObject#manbonify(yo)')

    object = TestObject.new
    assert_equal 'fake return value', object.manbonify('yo')
  end

  def test_mount_wrap_notifies_before_and_after_class_methods
    TestObject.class_eval { define_singleton_method(:classest_of_methods) {} }

    actor = Bystander::Actor.new(TestObject)
    notify = Bystander::Hooks::Notify.new(actor)
    notify.mount(:classest_of_methods, :wrap)

    Bystander.transport.expects(:notify).with('Calling: TestObject::classest_of_methods()')
    Bystander.transport.expects(:notify).with('Finished: TestObject::classest_of_methods()')
    TestObject.classest_of_methods
  end
end
