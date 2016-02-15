require "spec_helper"

RSpec.describe Outside::API do
  include Rack::Test::Methods

  def app
    Outside::API
  end  

  context 'GET /api/v1/zipcode' do
    it 'fails with too short zipcode' do
      get '/api/v1/zipcode', {zipcode: "840"}
      expect(last_response.status).to eq(400)
    end


    it 'returns a correct response' do
      get '/api/v1/zipcode', {zipcode: "84043"}
      expect(last_response.status).to eq(200)
      j = JSON.parse(last_response.body)
      expect(j["observation"]).to_not be_nil
    end
  end  
end