require 'test_helper'

class ActsHashTest < MiniTest::Test
  def test_add_adds_the_given_acts_in_the_acts_hash_for_given_actor_and_method
    scene = Bystander::Scene.new('test_scene')
    acts = Bystander::ActsHash.new(scene)

    acts.add :an_actor, :a_method
    acts.add :another_actor, :another_method

    assert_kind_of Bystander::Act, acts[:an_actor__a_method]
    assert_kind_of Bystander::Act, acts[:another_actor__another_method]
  end
end
