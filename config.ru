require File.expand_path("lib/outside", File.dirname(__FILE__))

use Rack::Session::Cookie
run Rack::Cascade.new [Outside::API, Outside::Web]
