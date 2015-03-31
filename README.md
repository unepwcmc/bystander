# Bystander

A Ruby Gem that makes it easy to log your application's Critical Paths™ without
having to touch the behaviour of your code.

![Bystander in action, in a Slack channel](/screenshot.png?raw=true)

## Getting started

### How does it work?

With some basic configuration, Bystander hooks in to your Ruby classes
and creates a log entry every time one of the methods you specify is
called, and when the method returns.

### Where does it log to?

Anywhere! Well, if you want it to. Currently it defaults to logging to a
[Slack](https://slack.com) channel, but is designed to work with any
transport method (warning: you're gonna have to write some code).

### Usage

#### Automatic Logging

Bystander consists of a DSL that allows you to define what method calls
you want to listen to. The concept is simple:

* You have one or more `Scene`s, which match to a process (such as
  importing a file)
* Each `Scene` consists of one or more `Actor`s, which define the
  classes that will be taking part in the process.
* Each `Scene` consists of one or more `Act`s, which define what methods
  to listen to.

```ruby
Bystander.scene('import') do
  actors do
    add Download
  end

  acts do
    add :download, :make_current, notify: :wrap
  end
end
```

An act has two types of notifiers: `wrap` and `before`. `wrap` notifies
your transport before and after the method is called, whereas `before`
only notifies as the method is called.

Whenever the methods are called, Bystander will log the call and the
return:

```
Calling: Download#make_current
Finished: Download#make_current
```

#### Manual Logging

Bystander has a basic capability to log custom messages, inline in your
code, like a normal logger.

```ruby
Bystander.log("I've made a huge mistake")
```

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
