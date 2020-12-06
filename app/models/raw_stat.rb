
class RawStat < ApplicationRecord
  require 'nokogiri'
  require 'open-uri'

  def self.pullALLData
    jsonData = JSON.load(open("https://covidtracking.com/api/v1/states/daily.json"))
    ##Inserts ALL data into the Stats table.
      self.helperVerifyAndInsertDataIntoRawStatsTable(jsonData)
  end 

  # def self.pullAndProcessDaysData(datesArr)
  #   for d in datesArr do
  #     jsonData = JSON.load(open("https://covidtracking.com/api/v1/states/#{d}.json"))
  #     RawStat.where(date: d).destroy_all
  #     self.helperVerifyAndInsertDataIntoRawStatsTable(jsonData)
  #   end ## Ends for loop for dates
  # end 

  def self.checkToSeeIfTodaysDataIsAvailable(today_yyyymmdd)
    todaysUSDataHash = JSON.load(open("https://api.covidtracking.com/v1/us/current.json"))
    mostRecentDateAvailable = todaysUSDataHash[0]["date"]
    if today_yyyymmdd === mostRecentDateAvailable
      return true
    else
      return false
    end
  end 

  def self.pullAndProcessDaysData(datesArr)
    allJsonData = JSON.load(open("https://covidtracking.com/api/v1/states/daily.json"))
    subsetJsonData = allJsonData.first(2400)
    for d in datesArr do
      ##Inserts ALL data into the Stats table.
      jsonData = subsetJsonData.select { |obj| obj["date"] == d }     
        self.helperVerifyAndInsertDataIntoRawStatsTable(jsonData, d)
    end ## Ends for loop for dates
  end 


  def self.helperVerifyAndInsertDataIntoRawStatsTable(jsonData, date = "all")
    if (!!jsonData && jsonData.kind_of?(Array) && jsonData.length > 0)
      if date != "all"
        RawStat.where(date: date).destroy_all
      end
      jsonData.each { |x| 
        if x["date"] > 20200227
          ## This adds the record to the RawStat table
          RawStat.create(
            date: x["date"],
            state: x["state"],
            positive: x["positive"],
            negative: x["negative"],
            hospitalized: x["hospitalizedCurrently"],
            death: x["death"],
            total: x["totalTestResults"],
            dateChecked: x["dateChecked"],
            deathIncrease: x["deathIncrease"],
            hospitalizedIncrease: x["hospitalizedIncrease"],
            negativeIncrease: x["negativeIncrease"],
            positiveIncrease: x["positiveIncrease"],
            totalTestResultsIncrease: x["totalTestResultsIncrease"]
          ) 
        end
      }  ## Ends Each loop
    end ## ends IF making sure json returned is good
  end


  # def self.timeTest
  #   startTime = Time.new
  #         #XYZ  
  #   endTime = Time.new
  #   puts "Chopping off the first 400 took this long:  #{endTime - startTime}"

  #   startTime = Time.new
  #         #XYZ
  #   endTime = Time.new
  #   puts "just selecting date from ALL took this long:  #{endTime - startTime}"
  # end

end   # Ends Class




