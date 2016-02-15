module Outside
  class Status
    attr_accessor :message, :summary

    def initialize(observations = [])
      aqi_obs = observations.find {|i| i["ParameterName"] == "PM2.5"}
      if aqi_obs
        @message = ambiguous_message(aqi_obs["Category"]["Name"])
        @summary = ambiguous_summary(aqi_obs["Category"]["Name"])
      else
        raise "No AQI observation found: #{observations.inspect}"
      end
    end

    # Generate a cute, subjective status message based on AQI category name
    def ambiguous_message(category = "")
      case category
      when "Good"
        ["Things are looking good.", "Perfect day for a walk"].sample
      when "Moderate"
        ["The air could be better", "Meh, not great."].sample
      when "Unhealthy for Sensitive Groups"
        ["Better to stay inside.", "Stay inside if you're sensitive."].sample
      when "Unhealthy"
        ["Stay inside if you can."].sample      
      when "Very Unhealthy"
        ["It's bad out there."].sample
      when "Hazardous"
        ["HAZARDOUS. DO NOT GO OUTSIDE."].sample
      else
        "No sure. Try again later."
      end
    end

    def ambiguous_summary(category = "")
      case category
      when "Good"
        "YES"
      when "Moderate"
        "YES"
      when "Unhealthy for Sensitive Groups"
        "MAYBE"
      when "Unhealthy"
        "NO"    
      when "Very Unhealthy"
        "NO"
      when "Hazardous"
        "NO"
      else
        "N/A"
      end
    end  


    def to_s
      @message
    end
  end
end