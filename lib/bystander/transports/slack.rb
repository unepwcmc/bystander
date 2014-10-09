require 'slack-notifier'

module Bystander
  module Transports
    module Slack
      SETTINGS = [:domain, :username, :auth_token, :channel, :prepend]

      SETTINGS.each do |setting|
        define_singleton_method(setting) do |*args|
          return instance_variable_get(:"@#{setting}") if args.length == 0
          instance_variable_set(:"@#{setting}", args[0])
        end
      end

      def self.slack
        @slack ||= ::Slack::Notifier.new(domain, auth_token).tap { |slack|
          slack.channel = channel
          slack.username = username
        }
      end

      def self.notify message
        slack.ping "_#{prepend}_ `#{message}`"
      end

      def self.configure
        yield self
      end

    end
  end
end
