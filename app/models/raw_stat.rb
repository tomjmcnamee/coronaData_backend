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

  # def self.processALLData
  #     currentDate = Time.now.strftime("%Y%m%d")
  
  #     allDatesArr = RawStat.distinct.pluck("date").sort
  #     allStatesArr = RawStat.distinct.pluck("state").sort
  #     allCountTypesArr = [ "positive", "negative", "pending", "death", "total"]
  
  #     for state in allStatesArr do
  #       for date in allDatesArr do
  #         tempObj = RawStat.find_by(date: date, state: state )
  #         for type in allCountTypesArr do
  #           ProcessedStat.create(state_id: State.find_by(state_abbreviation: tempObj.state).id,
  #             count_type: type,
  #             date => tempObj[type]
  #           )
  #         end  #ends type loop        
  #       end  #date type loop  
  #     end  #ends state loop  

      
  #   end 

  

end
