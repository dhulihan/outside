module Outside
  class AirNow
    class << self
      def api_base
        "http://www.airnowapi.org"
      end 

      def api_key
        ENV['AIRNOW_API_KEY']
      end

      # get realtime observations
      def observations(options = {})
        options[:distance] ||= 25
        options[:format]   ||= 'application/json'

        if options[:zipcode]
          # make AirNow API call to fetch current conditions
          r = RestClient.get AirNow.api_base + "/aq/observation/zipCode", {
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

      # Get forecasts
      def forecasts(options = {})
        options[:distance] ||= 25
        options[:format]   ||= 'application/json'

        if options[:zipcode]
          # make AirNow API call to fetch current conditions
          r = RestClient.get AirNow.api_base + "/aq/forecast/zipCode", {
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

      def forecast_today(options = {})
        forecasts(options).first
      end

      def date_fmt
        "%F"
      end
    end 
  end 
end