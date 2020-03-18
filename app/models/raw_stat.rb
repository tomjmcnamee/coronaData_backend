require 'nokogiri'
require 'open-uri'

class RawStat < ApplicationRecord
  def self.pullALLData
    currentDate = Time.now.strftime("%Y%m%d")
    jsonData = JSON.load(open("https://covidtracking.com/api/states/daily.json"))

    ##Inserts ALL data into the Stats table.
    jsonData.each { |x| 
      RawStat.create(x) 
    }
  end 

  def self.pullDaysData
    currentDate = Time.now.strftime("%Y%m%d")

    jsonData = JSON.load(open("https://covidtracking.com/api/states/daily?date=#{currentDate}"))

    ##Inserts ALL data into the Stats table.
    jsonData.each { |x| 
      RawStat.create(x) 
    }
  end 

  

end
