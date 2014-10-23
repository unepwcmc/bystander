require 'test_helper'

class ActTest < MiniTest::Test
  def test_initialize_sets_actor_method_and_hooks
    act = Bystander::Act.new Object, :a_method, {notify: :wrap}

    assert_equal Object, act.actor
    assert_equal :a_method, act.method
    assert_equal({notify: :wrap}, act.hooks)
  end

  def test_load_hooks_adds_acts_hooks_to_the_actor
    ensure_lambda = -> {}
    hooks = {notify: :wrap, ensure: ensure_lambda}

    actor_mock = mock
    actor_mock.expects(:add_hook).with(:method, :notify, :wrap)
    actor_mock.expects(:add_hook).with(:method, :ensure, ensure_lambda)

    act = Bystander::Act.new actor_mock, :method, hooks
    act.load_hooks
  end
end
