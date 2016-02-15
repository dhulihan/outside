require "json"
module Outside
  class Status
    attr_accessor :message, :summary, :scale_percent

    def initialize(observation)
      if observation["Category"]
        @message = ambiguous_message(observation["Category"]["Name"])
        @summary = ambiguous_summary(observation["Category"]["Name"])
      else
        raise 'observation["Cateogry"] undefined'
      end
    end

    # Generate a cute, subjective status message based on AQI category name
    def ambiguous_message(category = "")
      case category
      when "Good"
        ["Things are looking good.", "Perfect day for a walk"].sample
      when "Moderate"
        ["The air could be better though.", "Meh, not great.", "Air quality is MODERATE"].sample
      when "Unhealthy for Sensitive Groups"
        ["Unhealthy for Sensitive Groups", "Stay inside if you're sensitive.", "You shouldn't if you have allergies or asthma.", "Pregnant? Better not risk it."].sample
      when "Unhealthy"
        ["Stay inside if you can.", "Cancel that picnic.", "The current air quality is UNHEALTHY."].sample      
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

    def to_json(options = nil)
      {message: @message, summary: @summary, scale_percent: @scale_percent}.to_json
    end 
  end
end