module UI::Components
  class List
    def render input: ''
      files = Pathname.glob Pathname.new("#{input}/*.txt").expand_path
      context = OpenStruct.new files: files
      html = Tilt.new("#{__dir__}/list.slim").render context

      { html: html }
    end
  end
end
