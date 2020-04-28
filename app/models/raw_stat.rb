
class RawStat < ApplicationRecord
  require 'nokogiri'
  require 'open-uri'
  def self.pullALLData
    jsonData = JSON.load(open("https://covidtracking.com/api/states/daily.json"))
    puts "raw data #{jsonData}"
    ##Inserts ALL data into the Stats table.
    if (!!jsonData && jsonData.kind_of?(Array) && jsonData.length > 0)
      jsonData.each { |x| 
        if x["date"] > 20200227
          # RawStat.create(x) 
          # pending = 0
          # if !!x.pending
          #   pending = x["pending"]
          # end
          RawStat.create(
            date: x["date"],
            state: x["state"],
            positive: x["positive"],
            negative: x["negative"],
            hospitalized: x["hospitalizedCumulative"],
            death: x["death"],
            total: x["total"],
            dateChecked: x["dateChecked"],
            deathIncrease: x["deathIncrease"],
            hospitalizedIncrease: x["hospitalizedIncrease"],
            negativeIncrease: x["negativeIncrease"],
            positiveIncrease: x["positiveIncrease"],
            totalTestResultsIncrease: x["totalTestResultsIncrease"]
          ) 
        end
      }
    end
  end 

  def self.pullAndProcessDaysData(arrOfDatesToProcess)
    for d in arrOfDatesToProcess do
      jsonData = JSON.load(open("https://covidtracking.com/api/states/daily?date=#{d}"))
      ##Inserts ALL data into the Stats table.
      if (!!jsonData && jsonData.kind_of?(Array) && jsonData.length > 0)
        jsonData.each { |x| 
          # RawStat.create(x) 
          RawStat.create(
            date: x["date"],
            state: x["state"],
            positive: x["positive"],
            negative: x["negative"],
            hospitalized: x["hospitalizedCumulative"],
            death: x["death"],
            total: x["total"],
            dateChecked: x["dateChecked"],
            deathIncrease: x["deathIncrease"],
            hospitalizedIncrease: x["hospitalizedIncrease"],
            negativeIncrease: x["negativeIncrease"],
            positiveIncrease: x["positiveIncrease"],
            totalTestResultsIncrease: x["totalTestResultsIncrease"]
          )
        } ## ends each loop
      end ## ends IF making sure json returned is good
    end ## Ends loop of dates to process
  end 
end
