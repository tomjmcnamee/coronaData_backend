require 'nokogiri'
require 'open-uri'

class ProcessedStat < ApplicationRecord

  belongs_to :state

  
  # def self.processALLData
  #   currentDate = Time.now.strftime("%Y%m%d")

  #   allDatesArr = RawStat.distinct.pluck("date").sort
  #   allStatesArr = RawStat.distinct.pluck("state").sort
  #   allCountTypesArr = [ "positive", "negative", "pending", "death", "total"]

  #   for state in allStatesArr do
  #     for date in allDatesArr do
  #       tempObj = RawStat.find_by(date: date, state: state )
  #       for type in allCountTypesArr do
  #         self.create(state_id: State.find_by(state_abbreviation: tempObj.state).id,
  #           count_type: type,
  #           date => tempObj[type]
  #         )
  #       end  #ends type loop        
  #     end  #date type loop  
  #   end  #ends state loop  

    
  # end 

  # def self.processDaysData
  #   currentDate = Time.now.strftime("%Y%m%d")

  #   RawStat.where(date: currentDate).each { |obj| 
  #   ProcessedStat.create(
  #     state_id: State.find_by(state_abbreviation: obj.state).id, 
  #     date: obj.date, 
  #     positive: obj.positive, 
  #     negative: obj.negative, 
  #     pending: obj.pending, 
  #     death: obj.death, 
  #     total: obj.total, 
  #     dateChecked: obj.dateChecked
  #   )
  # }
  # end 

  

end
