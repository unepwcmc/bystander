require 'test_helper'

class TransportsSlackTest < Minitest::Test
  def test_notify_pings_slack
    message = 'a message'

    slack_mock = mock()
    slack_mock.expects(:ping).with("__ `#{message}`")
    Bystander::Transports::Slack.stubs(:slack).returns(slack_mock)

    Bystander::Transports::Slack.notify message
  end
end
