require 'test_helper'

class TestObject; end;
class AnotherTestObject; end;

class ActorsHashTest < MiniTest::Test
  def test_add_adds_the_given_actor_in_the_actors_hash_with_given_alias
    actors = Bystander::ActorsHash.new
    actors.add TestObject, :an_alias
    actors.add AnotherTestObject, :another_alias

    assert_equal TestObject, actors[:an_alias]
    assert_equal AnotherTestObject, actors[:another_alias]
  end
end
