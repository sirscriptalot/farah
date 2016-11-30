module Farah
  module Helpers
    def run(klass, action, *args)
      klass.new(self, action).call(*args)
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

    def success(payload)
      throw :finish, context.send("on_#{action}_success", payload)
    end

    def failure(payload)
      throw :finish, context.send("on_#{action}_failure", payload)
    end
  end
end
