require 'test_helper'

class ConfigurationTest < MiniTest::Test
  def test_scene_creates_and_yields_a_new_scene_with_the_given_name
    scene_name = 'test'

    scene_mock = mock
    scene_mock.expects(:actors)
    Bystander::Scene.expects(:new).with(scene_name).returns(scene_mock)

    Bystander.scene(scene_name) do
      actors
    end
  end
end
