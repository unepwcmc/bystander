require 'slack-notifier'

module Bystander
  module Transports
    module Slack
      SETTINGS = [:domain, :username, :auth_token, :channel]

      SETTINGS.each do |setting|
        define_singleton_method(setting) do |*args|
          return instance_variable_get(:"@#{setting}") if args.length == 0
          instance_variable_set(:"@#{setting}", args[0])
        end
      end

      def self.slack
        @slack ||= ::Slack::Notifier.new domain, auth_token, channel: channel, username: username
      end

      def self.notify message
        slack.ping message
      end

      def self.configure
        yield self
      end

    end
  end
end
