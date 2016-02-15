require "sinatra"

module Outside
  class Web < Sinatra::Base
    root = File.expand_path("../..", File.dirname(__FILE__))
    set :root, root
    get '/' do
      send_file "public/index.html"
    end
  end
end
