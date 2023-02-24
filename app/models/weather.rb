class Weather < ApplicationRecord
  class << self
    include HttpartyHelper

    def validate_search_results(params)
      return params && params["city"] && params["weather"] && params["description"]
    end

    def API_key
      return "172561d1775c49d7859222125232302"
    end

    def search(city)
      city = CGI.escape city
      url = "http://api.weatherapi.com/v1/current.json?key=#{self.API_key}&q=#{city}&aqi=no"
      weatherresult = get(url, {"Content-Type" => "application/json"})

      return {
        :body => weatherresult.body,
        :status => weatherresult.code
      }
    end
  end 
end
