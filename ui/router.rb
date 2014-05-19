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

  class Router
    def initialize &b
      @messages = []
      @pages = {}

      instance_eval &b if block_given?
    end

    def page pathname, &b
      @pages[pathname] = Page.new &b
    end

    def << message
      data = JSON.parse message
      pathname = data['pathname']

      if page = @pages[pathname]
        page << data
        @messages += page.messages
      end
    end

    def messages
      response = @messages.map { |hash| hash.to_json }
      @messages = []

      response
    end
  end
end
