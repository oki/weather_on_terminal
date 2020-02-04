#!/usr/bin/env ruby

require "rubygems"
require "bundler/setup"
require "pp"
require "open-uri"
require "json"

Bundler.require
Dotenv.load

ForecastIO.api_key = ENV.fetch('FORECAST_KEY')
ForecastIO.default_params = { units: 'si' }

# http://unicode-table.com/en/blocks/miscellaneous-symbols-and-pictographs/
# http://apps.timwhitlock.info/emoji/tables/unicode

begin
  # geo_data = JSON.load(open('http://freegeoip.net/json/'))
  geo_data = JSON.load(open("http://ip-api.com/json"))
  # pp geo_data

  forecast = ForecastIO.forecast(geo_data["lat"], geo_data["lon"], time: Time.now.to_i)

  # pp forecast

  icon = forecast.currently["icon"] rescue '☹'

  # clear-day, clear-night, rain, snow, sleet, wind, fog, cloudy, partly-cloudy-day, or partly-cloudy-night
  puts case icon
  when "clear-day"
    # '☀'
    '🔆'
  when "clear-night"
    '⋆⭑'
  when "rain"
     '☂'
    #'🌂'
  when "snow"
    '❄'
  when "sleet"
    '*"'
  when "wind"
    #'⚑'
    #"🎌"
    "🏁"
  when "fog"
    '☁'
  when "cloudy"
    '☁'
  when "partly-cloudy-day"
    '☁☀'
  when "partly-cloudy-night"
    '☁'
  else
    '☢'
  end

rescue => e
  if STDIN.tty?
    puts e
  end
  puts '☹'
end
