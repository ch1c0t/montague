module UI
  class Page
    def initialize &b
      @ids = {}
      @events = {}
      @messages = []

      instance_eval &b if block_given?
    end

    def id name, component
      @ids[name] = component
    end

    def on id, &b
      @events[id] = b
    end

    def update id, **kwargs
      message = @ids[id].render **kwargs
      message[:id] = id

      @messages << message
    end

    def << data
      id = data['id']

      if event = @events[id]
        event.call data
      end
    end

    def messages
      response = @messages; @messages = []
      response
    end
  end
end
