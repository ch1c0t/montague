require 'slim'

require 'ostruct'
require 'pathname'
require 'json'

module UI
  module Components; end
end

Dir['./ui/lib/components/*.rb'].each { |file| require file }

def Object.const_missing name
  const_get "UI::Components::#{name}"
end

require './ui/lib/page'
require './ui/lib/router'
