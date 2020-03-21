require 'nokogiri'
require 'open-uri'

class RawStat < ApplicationRecord
  def self.pullALLData
    jsonData = JSON.load(open("https://covidtracking.com/api/states/daily.json"))
    ##Inserts ALL data into the Stats table.
    jsonData.each { |x| 
    RawStat.create(x) 
    }
  end 

  def self.pullAndProcessDaysData(arrOfDatesToProcess)
    for d in arrOfDatesToProcess
      jsonData = JSON.load(open("https://covidtracking.com/api/states/daily?date=#{d}"))
      ##Inserts ALL data into the Stats table.
      if (!!jsonData && jsonData.kind_of?(Array) && jsonData.length > 0)
        jsonData.each { |x| 
          RawStat.create(x) 
        } ## ends each loop
      end ## ends IF making sure json returned is good
    end ## Ends loop of dates to process
  end 
end
