# submitted by: djmainka

require 'open-uri'
require 'json'

# prompt for location
print("Enter an address, city or zipcode: ")
parameters = "address=#{gets.chomp}&sensor=false"

# query Google Geocoding JSON API, escape the URI too to make sure spaces are handled properly
# to get the lat/lng for the location requested
json_data = open(URI.escape("http://maps.googleapis.com/maps/api/geocode/json?#{parameters}")).read

data = JSON.parse(json_data)

if (data["status"] == "OK")
  # get the lat/lon to use as inputs to the OpenWeatherMap API
  lat = data["results"][0]["geometry"]["location"]["lat"]
  lon = data["results"][0]["geometry"]["location"]["lng"]

  # query OpenWeatherMap JSON API, escape the URI too to make sure spaces are handled properly
  # using the lat/lng from the prior request
  # added units to not have to manually convert from Kelvin to Fahrenheit
  json_data = open(URI.escape("http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&units=imperial")).read

  data = JSON.parse(json_data)

  puts "#{data["main"]["temp"].to_f.round(1)}f"
else
  puts "Invalid address, city or zipcode entered.  Response Status: #{data["status"]}"
end

# test inputs:
# 222 Merchandise Mart Plz, Chicago, IL
