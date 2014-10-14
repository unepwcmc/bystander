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
    Bystander::ActsHash.stubs(:new).returns(acts_mock)

    scene.acts do
      add :actor, :method
      add :another_actor, :another_method
    end
  end
end
