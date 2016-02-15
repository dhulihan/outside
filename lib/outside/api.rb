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
      optional :distance, type: Integer, default: 25
    end 
    get :zipcode do
      zipcode = params[:zipcode]
      observations = Outside::AirNow.observations(zipcode: zipcode)
      raise "No monitoring stations found within #{params[:distance]} miles of #{params[:zip]}" if observations.empty?
      pm_obs = observations.find {|i| i["ParameterName"] == "PM2.5"}
      raise "No PM2.5 reporting station within #{params[:distance]} miles of #{params[:zipcode]}" unless pm_obs
      status = Outside::Status.new([pm_obs])
      { 
        observations: observations,
        category: pm_obs["Category"]["Name"],
        message: status.message,
        summary: status.summary
      }
    end

    get :hello do
      { msg: "Hello"}
    end
  end
end
