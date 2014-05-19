module Resource
  class Settings < Sinatra::Base
    get '/book_source' do
      slim :book_source
    end
  end
end
