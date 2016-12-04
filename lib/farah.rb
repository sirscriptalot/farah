module Farah
  module Helpers
    def start(klass, action, *args)
      klass.new(self, action).call(*args)
    end
  end

  module Results
    class Result
      attr_reader :payload

      def initialize(payload)
        @payload = payload
      end
    end

    class Success < Result
      def success?
        true
      end

      def failure?
        false
      end
    end

    class Failure < Result
      def success?
        false
      end

      def failure?
        true
      end
    end
  end

  class Runner
    def initialize(context, action)
      @context = context
      @action  = action
    end

    def call(*args)
      catch(:finish) { send(action, *args) }
    end

    private

    attr_reader :context, :action

    def success!(payload)
      throw :finish, Results::Success.new(payload)
    end

    def failure!(payload)
      throw :finish, Results::Failure.new(payload)
    end
  end
end
