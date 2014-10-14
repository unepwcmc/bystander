require 'test_helper'

class ActTest < MiniTest::Test
  def test_initialize_sets_actor_method_and_hooks
    act = Bystander::Act.new Object, :a_method, {notify: :wrap}

    assert_equal Object, act.actor
    assert_equal :a_method, act.method
    assert_equal({notify: :wrap}, act.hooks)
  end
end
