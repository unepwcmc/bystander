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

  def test_add_hook_creates_and_mounts_the_hook
    hook_mock = mock
    hook_mock.expects(:mount)
    actor = Bystander::Actor.new Object

    Bystander::Hooks::Notify.expects(:new).with(actor).returns(hook_mock)

    actor.add_hook :method, :notify, :wrap
  end
end
