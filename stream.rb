require 'redis'
require 'slim'

require 'ostruct'
require 'pathname'
require 'json'

module UI
  module Components
  end
end

Dir['./ui/components/*.rb'].each { |file| require file }
require './ui/router'

def Object.const_missing name
  const_get "UI::Components::#{name}"
end

router = UI::Router.new do
  page '/settings/book_source' do
    id 'list', List.new

    on 'path' do |data|
      update 'list', array: (data['input'].split '')
    end
  end
end

r0 = Redis.new; r1 = Redis.new

r0.psubscribe 'in:*' do |on|
  on.pmessage do |_pattern, channel, message|
    router << message

    _in, uuid = channel.split ':'
    router.messages.each do |message|
      r1.publish "out:#{uuid}", message
    end
  end
end
