# submitted by: djmainka

require 'open-uri'
require 'json'

# prompt for origin and destination
print("Enter an origin address: ")
origin = gets.chomp

print("Enter an destination address: ")
destination = gets.chomp

parameters = "origin=#{origin}&destination=#{destination}&sensor=false"

# query Google Directions JSON API, escape the URI too to make sure spaces are handled properly
json_data = open(URI.escape("http://maps.googleapis.com/maps/api/directions/json?#{parameters}")).read

data = JSON.parse(json_data)

# check that we got a valid response
if (data["status"] == "OK")
  print("Total travel time driving: ")
  puts data["routes"][0]["legs"][0]["duration"]["text"]
  print("Total distance traveled: ")
  puts data["routes"][0]["legs"][0]["distance"]["text"]
else
  puts "Invalid origin or destination entered.  Response Status: #{data["status"]}"
end

# test inputs:
# 222 Merchandise Mart Plz, Chicago, IL
# 700 N Art Museum Dr, Milwaukee, WI
