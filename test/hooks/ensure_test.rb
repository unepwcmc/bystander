require 'test_helper'

class TestObject < Object; end;

class HooksEnsureTest < MiniTest::Test
  def test_mount_notifies_if_ensure_fails_after_instance_method
    TestObject.class_eval { define_method(:manbonify) {|an_arg| 'fake return value'} }

    actor = Bystander::Actor.new(TestObject)
    ensure_hook = Bystander::Hooks::Ensure.new(actor)
    ensure_hook.mount(:manbonify, -> (return_value) { false })

    Bystander.transport.expects(:notify).with('Ensure failed: TestObject#manbonify(yo)')

    object = TestObject.new
    assert_equal 'fake return value', object.manbonify('yo')
  end

  def test_mount_notifies_if_ensure_fails_after_class_method
    TestObject.class_eval { define_singleton_method(:classest_of_methods) { } }

    actor = Bystander::Actor.new(TestObject)
    ensure_hook = Bystander::Hooks::Ensure.new(actor)
    ensure_hook.mount(:classest_of_methods, -> (return_value) { false })

    Bystander.transport.expects(:notify).with('Ensure failed: TestObject::classest_of_methods()')

    TestObject.classest_of_methods
  end
end

