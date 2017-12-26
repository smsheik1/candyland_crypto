class WelcomeController < ApplicationController
  def index

    @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK 
     TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY 
     NJ CT RI MA VT NH ME DC).sort!

      if params[:city] != nil
          params[:city].gsub!(" ", "_")
      end

      if params[:state] != "" && params[:city] != "" && params[:state] != nil && params[:city] != nil
     
   results = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")

        if results['response']['error'] == nil || results['error'] ==""
    
            if results.key?("location") 
          @location = results['location']['city']
              @temp_f = results['current_observation']['temp_f']
          @temp_c = results['current_observation']['temp_c']
          @weather_icon = results['current_observation']['icon_url']
          @weather_words = results['current_observation']['weather']
          @forecast_link = results['current_observation']['forecast_url']
          @real_feel_f = results['current_observation']['feelslike_f']
          @real_feel_c = results['current_observation']['feelslike_c']
          else
          @error = "City/State combination does not exist." 
      end   
          else
         # if there is an error, we report it to our user via the @error variable   
          @error = results['response']['error']['description']
          end
    end
  end

  def test
  	response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/TX/Dallas.json")
  
  @location = response['location']['city']
  @temp_f = response['current_observation']['temp_f']
  @temp_c = response['current_observation']['temp_c']
  @weather_icon = response['current_observation']['icon_url']
  @weather_words = response['current_observation']['weather'] 
  @forecast_link = response['current_observation']['forecast_url']
  @real_feel = response['current_observation']['feelslike_f']
  end


  def wumbo 
    puts 'this is wumbo speaking'
    x = 6
    puts x
  end

  def wizard
    x = 10
    y = 10
    puts x+y
  end
  
end
