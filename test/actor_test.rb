require 'test_helper'

class ActorTest < MiniTest::Test
  def test_initialize_sets_class_and_optional_value_for_scene
    scene = Bystander::Scene.new('test_scene')
    actor = Bystander::Actor.new(Object, scene)
    actor_without_scene = Bystander::Actor.new Object

    assert_equal Object, actor.entity
    assert_equal scene, actor.scene
    assert_nil actor_without_scene.scene
  end

  def test_add_hook_calls_the_hook_method_on_the_entity
    class_mock = mock
    class_mock.expects(:notify).with(:method, :wrap)

    actor = Bystander::Actor.new class_mock
    actor.add_hook :method, :notify, :wrap
  end
end
