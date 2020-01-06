require 'shipit/webhooks/handlers'

module Shipit
  module Webhooks
    class << self
      def default_handlers
        {
          'push' => [Handlers::PushHandler],
          'status' => [Handlers::StatusHandler],
          'membership' => [Handlers::MembershipHandler],
          'check_suite' => [Handlers::CheckSuiteHandler],
        }
      end

      def handlers
        @handlers ||= reset_handler_registry
      end

      def reset_handler_registry
        @handlers = default_handlers
      end

      def register_handler(event, callable = nil, &block)
        handlers[event] ||= []
        handlers[event] << callable if callable
        handlers[event] << block if block_given?
      end

      def for_event(event)
        handlers.fetch(event) { [] }
      end
    end
  end
end
