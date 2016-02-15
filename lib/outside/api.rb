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
    desc "Get conditions by ZIP code" do
      detail "Please provide a five digit US ZIP code"
    end
    params do
      requires :zipcode, length_exactly: 5
    end 
    get :zipcode do
      zipcode = params[:zipcode]
      observations = Outside::AirNow.observations(zipcode: zipcode)
      { 
        observations: observations,
        message: Outside::Status.new(observations).message
      }
    end

    get :hello do
      { msg: "Hello"}
    end
  end
end
