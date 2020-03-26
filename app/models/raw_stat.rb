
class RawStat < ApplicationRecord
  require 'nokogiri'
  require 'open-uri'
  def self.pullALLData
    jsonData = JSON.load(open("https://covidtracking.com/api/states/daily.json"))
    puts "raw data #{jsonData}"
    ##Inserts ALL data into the Stats table.
    if (!!jsonData && jsonData.kind_of?(Array) && jsonData.length > 0)
      jsonData.each { |x| 
        RawStat.create(x) 
        # RawStat.create(
        #   date: x[date],
        #   state: x[state],
        #   positive: x[positive],
        #   negative: x[negative],
        #   pending: x[pending],
        #   hospitalized: x[hospitalized],
        #   death: x[death],
        #   total: x[total],
        #   dateChecked: x[dateChecked],
        #   totalTestResults: x[totalTestResults],
        #   deathIncrease: x[deathIncrease],
        #   hospitalizedIncrease: x[hospitalizedIncrease],
        #   negativeIncrease: x[negativeIncrease],
        #   positiveIncrease: x[positiveIncrease],
        #   totalTestResultsIncrease: x[totalTestResultsIncreas]e
        # ) 
      }
    end
  end 

  def self.pullAndProcessDaysData(arrOfDatesToProcess)
    for d in arrOfDatesToProcess do
      jsonData = JSON.load(open("https://covidtracking.com/api/states/daily?date=#{d}"))
      ##Inserts ALL data into the Stats table.
      if (!!jsonData && jsonData.kind_of?(Array) && jsonData.length > 0)
        jsonData.each { |x| 
          RawStat.create(x) 
          # RawStat.create(
          #   date: x.date,
          #   state: x.state,
          #   positive: x.positive,
          #   negative: x.negative,
          #   pending: x.pending,
          #   hospitalized: x.hospitalized,
          #   death: x.death,
          #   total: x.total,
          #   dateChecked: x.dateChecked,
          #   totalTestResults: x.totalTestResults,
          #   deathIncrease: x.deathIncrease,
          #   hospitalizedIncrease: x.hospitalizedIncrease,
          #   negativeIncrease: x.negativeIncrease,
          #   positiveIncrease: x.positiveIncrease,
          #   totalTestResultsIncrease: x.totalTestResultsIncrease
          # )
        } ## ends each loop
      end ## ends IF making sure json returned is good
    end ## Ends loop of dates to process
  end 
end
