# submitted by: djmainka

require 'open-uri'
require 'json'

# prompt for location
print("Enter an address, city or zipcode: ")
parameters = "address=#{gets.chomp}&sensor=false"

# query Google Geocoding JSON API, escape the URI too to make sure spaces are handled properly
json_data = open(URI.escape("http://maps.googleapis.com/maps/api/geocode/json?#{parameters}")).read

data = JSON.parse(json_data)

# check that we got a valid response
if (data["status"] == "OK")
  print("Latitude: ")
  puts data["results"][0]["geometry"]["location"]["lat"]
  print("Longitude: ")
  puts data["results"][0]["geometry"]["location"]["lng"]
else
  puts "Invalid address, city or zipcode entered.  Response Status: #{data["status"]}"
end
