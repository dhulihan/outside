require 'rake'
require 'bundler'
Bundler.setup

desc 'load the Sinatra environment.'
task :environment do
  require File.expand_path('lib/outside', File.dirname(__FILE__))
end

desc "Get routes"
task :routes => :environment do
  Outside::API.routes.each do |api|
    method = api.route_method.ljust(10)
    path = api.route_path
    puts "     #{method} #{path}"
  end
end 