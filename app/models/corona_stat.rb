class CoronaStat < ApplicationRecord





  def pullData
    require 'nokogiri'
    require 'open-uri'

    currentDate = Time.now.strftime("%Y%m%d")

    jsonData = JSON.load(open("https://covidtracking.com/api/states/daily.json"))

    ##Inserts ALL data into the Stats table.
    jsonData.each { |x| 
      if x.date == currentDate
        CoronaStat.create(x) 
      end
    }
  end 
end
