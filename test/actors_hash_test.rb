require 'test_helper'

class TestObject; end;
class AnotherTestObject; end;

class ActorsHashTest < MiniTest::Test
  def test_initialize_sets_an_optional_scene
    scene = Bystander::Scene.new('test_scene')
    actors = Bystander::ActorsHash.new(scene)

    assert_equal scene, actors.scene
  end

  def test_add_adds_the_given_actor_in_the_actors_hash_with_given_alias
    actors = Bystander::ActorsHash.new

    actors.add TestObject, :an_alias
    actors.add AnotherTestObject, :another_alias

    assert_kind_of Bystander::Actor, actors[:an_alias]
    assert_kind_of Bystander::Actor, actors[:another_alias]
  end
end
