module UI
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
