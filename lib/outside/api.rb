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
  class API < Grape::API
    format :json
    prefix :api
    version :v1, using: :path
    rescue_from :all

    desc "Get conditions by ZIP code" do
      detail "Please provide a five digit US ZIP code"
    end
    params do
      requires :zipcode, length_exactly: 5
      optional :distance, type: Integer, default: 50
    end 
    get :zipcode do
      zipcode = params[:zipcode]
      forecasts = Outside::AirNow.forecasts(zipcode: zipcode)
      raise "No forecasts found within #{params[:distance]} miles of #{params[:zipcode]}" if forecasts.empty?
      
      # Get current PM2.5 reading for today
      pm2_forecast = forecasts.find {|i| i["ParameterName"] == "PM2.5"}
      raise "No PM2.5 reporting station within #{params[:distance]} miles of #{params[:zipcode]}" unless pm2_forecast
      pm2_status = Outside::Status.new(pm2_forecast)

      { 
        source: forecasts ? "forecast" : "current reading",
        forecasts: forecasts,
        status: {
          pm2: pm2_status,
          o3: nil 
        }
      }
    end

    get :hello do
      { msg: "Hello"}
    end
  end
end
