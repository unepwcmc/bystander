require 'test_helper'

class TransportsSlackTest < Minitest::Test
  def test_notify_pings_slack
    message = 'a message'

    slack_mock = mock()
    slack_mock.expects(:ping).with("```#{message}```")
    Bystander::Transports::Slack.stubs(:slack).returns(slack_mock)

    Bystander::Transports::Slack.notify message
  end

  def test_notify_supports_prepending_to_message
    prepended_message = 'prepended message'
    message = 'a message'

    slack_mock = mock()
    slack_mock.expects(:ping).with("#{prepended_message}\n```#{message}```")
    Bystander::Transports::Slack.stubs(:slack).returns(slack_mock)
    Bystander::Transports::Slack.stubs(:prepend).returns(prepended_message)

    Bystander::Transports::Slack.notify message
  end
end
