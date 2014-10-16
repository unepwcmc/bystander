require 'test_helper'

class SceneTest < MiniTest::Test
  def test_actors_yields_a_block_with_actors_hash_as_context
    scene = Bystander::Scene.new('test')

    actors_mock = mock
    actors_mock.expects(:add).twice
    Bystander::ActorsHash.stubs(:new).returns(actors_mock)

    scene.actors do
      add Object, :one_object
      add Object, :another_object
    end
  end

  def test_acts_yields_a_block_with_acts_hash_as_context
    scene = Bystander::Scene.new('test')

    acts_mock = mock
    acts_mock.expects(:add).twice
    Bystander::ActsHash.expects(:new).with(scene).returns(acts_mock)

    scene.acts do
      add :actor, :method
      add :another_actor, :another_method
    end
  end

  def test_load_hooks_calls_load_hooks_on_all_its_acts
    scene = Bystander::Scene.new('test_scene')
    act_mock_1 = mock
    act_mock_1.expects(:load_hooks)
    act_mock_2 = mock
    act_mock_2.expects(:load_hooks)

    scene.acts[:act_mock_1] = act_mock_1
    scene.acts[:act_mock_2] = act_mock_2
    scene.load_hooks
  end
end
