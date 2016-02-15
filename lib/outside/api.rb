require "grape"
require "rest-client"
require "json"

class LengthExactly < Grape::Validations::Base
  def validate_param!(attr_name, params)
    unless params[attr_name].length == @option
      fail Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "must be #{@option} characters long"
    end
  end
end

module Outside
  class AirNow
    class << self
      def api_base
        "http://www.airnowapi.org"
      end 

      def api_key
        ENV['AIRNOW_API_KEY']
      end

      def observation(options = {})
        options[:distance] ||= 25
        options[:format]   ||= 'application/json'

        if options[:zipcode]
          # make AirNow API call to fetch current conditions
          r = RestClient.get AirNow.api_base + "/aq/observation/zipCode/current", {
            :params => {
              'zipCode' => options[:zipcode], 
              'distance' => options[:distance], 
              'format' => options[:format], 
              'API_KEY' => AirNow.api_key
            }
          }
          return JSON.parse(r.to_str)
        else 
          raise "options[:zipcode] undefined"
        end
      end 
    end 
  end 

  class API < Grape::API
    format :json
    prefix :api
    version :v1, using: :path
    desc "Get conditions by ZIP code" do
      detail "Please provide a five digit US ZIP code"
    end
    params do
      requires :zipcode, length_exactly: 5
    end 
    get :zipcode do
      zipcode = params[:zipcode]
      r = Outside::AirNow.observation(zipcode: zipcode)
      { 
        observation: r
      }
    end

    get :hello do
      { msg: "Hello"}
    end
  end
end
