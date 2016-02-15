require File.expand_path("lib/outside", File.dirname(__FILE__))

raise "AirNow api key not set. Please specify using $AIRNOW_API_KEY" unless ENV['AIRNOW_API_KEY']

#use Rack::Session::Cookie
run Rack::Cascade.new [Outside::API, Outside::Web]
