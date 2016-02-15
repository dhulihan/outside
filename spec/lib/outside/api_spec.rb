require "spec_helper"

RSpec.describe Outside::API do
  include Rack::Test::Methods

  def app
    Outside::API
  end  

  context 'GET /api/v1/zipcode' do
    it 'fails with too short zipcode' do
      get '/api/v1/zipcode', {zipcode: "840"}
      expect(last_response.status).to eq(500)
    end

    it 'returns a correct response' do
      get '/api/v1/zipcode', {zipcode: "84043"}
      j = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(j["forecasts"]).to_not be_nil
      expect(j["status"]).to_not be_nil
    end

    context 'using the zip from slc' do
      it 'should work also' do
        get '/api/v1/zipcode', {zipcode: "84101"}
        expect(last_response.status).to eq(200)
        j = JSON.parse(last_response.body)
        expect(j["error"]).to be_nil
        expect(j["forecasts"]).to_not be_nil
        expect(j["error"]).to be_nil
      end
    end    
  end  
end