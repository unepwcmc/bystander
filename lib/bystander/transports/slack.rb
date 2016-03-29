require 'slack-notifier'

module Bystander
  module Transports
    module Slack
      SETTINGS = [:webhook_url, :username, :channel, :prepend]

      SETTINGS.each do |setting|
        define_singleton_method(setting) do |*args|
          return instance_variable_get(:"@#{setting}") if args.length == 0
          instance_variable_set(:"@#{setting}", args[0])
        end
      end

      def self.slack
        @slack ||= ::Slack::Notifier.new(webhook_url).tap { |slack|
          slack.channel = channel
          slack.username = username
        }
      end

      def self.notify message
        formatted_message = "```#{message}```"
        slack.ping [prepend, formatted_message].compact.join("\n")
      end

      def self.configure &block
        self.instance_eval &block
      end

    end
  end
end
