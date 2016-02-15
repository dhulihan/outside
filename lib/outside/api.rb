require "grape"

module Outside
  class API < Grape::API
    format :json
    prefix :api
    version :v1, using: :path
    desc "Get conditions by ZIP code" do
      detail "Please provide a five digit US ZIP code"
    end
    get :zipcode do
      { zipcode: params[:zipcode] }
    end

    get :hello do
      { msg: "Hello"}
    end
  end
end
