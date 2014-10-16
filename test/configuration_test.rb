require 'test_helper'

class ConfigurationTest < MiniTest::Test
  def test_scene_creates_and_yields_a_new_scene_with_the_given_name
    scene_name = 'test'

    scene_mock = mock
    scene_mock.expects(:actors).twice.returns({})
    scene_mock.expects(:acts).returns({})
    scene_mock.expects(:load_hooks)
    Bystander::Scene.expects(:new).with(scene_name).returns(scene_mock)

    Bystander.scene(scene_name) do
      actors
    end
  end

  def test_scene_sets_the_general_actors_and_acts_from_the_created_scene
    scene_name = 'test'

    actor_mock = mock
    act_mock = mock

    scene_mock = mock
    scene_mock.stubs(:name).returns(scene_name)
    scene_mock.stubs(:actors).returns({an_actor: actor_mock})
    scene_mock.stubs(:acts).returns({an_act: act_mock})
    scene_mock.stubs(:load_hooks)

    Bystander::Scene.stubs(:new).returns(scene_mock)

    Bystander.scene(scene_name) { }

    assert_equal({test__an_actor: actor_mock}, Bystander.actors)
    assert_equal({test__an_act: act_mock}, Bystander.acts)
  end
end
