module UI::Components
  class List
    def render array: []
      context = OpenStruct.new list: array
      html = Tilt.new("#{__dir__}/list.slim").render context

      { html: html }
    end
  end
end
