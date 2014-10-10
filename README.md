# Bystander

A Ruby Gem that makes it easy to log your application's Critical Paths™ without
having to touch the behaviour of your code.

![Bystander in action, in a Slack channel](/screenshot.png?raw=true)

## How does it work?

With some basic configuration, Bystander hooks in to your Ruby classes
and creates a log entry every time one of the methods you specify is
called, and when the method returns.

## Where does it log to?

Anywhere! Well, if you want it to. Currently it defaults to logging to a
[Slack](https://slack.com) channel, but is designed to work with any
transport method (warning: you're gonna have to write some code).

### Configuration

#### Slack

Before you use Bystander, ensure you run the following configuration
block (e.g., in a Rails initializer):

```ruby
Bystander::Transports::Slack.configure do |slack|
  slack.domain      'wcmc'
  slack.username    'Bystander'
  slack.auth_token  ENV['SLACK_AUTH_TOKEN']
  slack.channel     '#bystander'

  # Prepend all messages with this string. Useful for env info, etc.
  slack.prepend     "#{ENV['RAILS_ENV']} - (##{Process.pid}):"
end
```

## Using Bystander in Tests

Most of the time you won't want Bystander running during tests. To
disable Bystander, preface your test code (for example, in your
`test_helper.rb`) with:

```
Bystander.enable_testing!
```
