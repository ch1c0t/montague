require 'bundler'
Bundler.require

set :public_folder, 'assets'
Dir['./resources/*.rb'].each { |file| require file }

map '/assets' do
  env = Sprockets::Environment.new
  env.append_path 'assets'

  run env
end

map '/settings' do
  run Resource::Settings
end
