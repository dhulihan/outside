require "sinatra"

module Outside
  class Web < Sinatra::Base
    get '/' do
      send_file "public/index.html"
    end
  end
end
