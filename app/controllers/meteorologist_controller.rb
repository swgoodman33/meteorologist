require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address}"

    adress_data = JSON.parse(open(url).read)

    latitude = adress_data["results"][0]["geometry"]["location"]["lat"]

    longitude = adress_data["results"][0]["geometry"]["location"]["lng"]

    url_for_weather = "https://api.darksky.net/forecast/7771547d3e6326836a7ae44c446b9931/#{latitude},#{longitude}"

    parsed_data = JSON.parse(open(url_for_weather).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
