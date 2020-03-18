require 'nokogiri'
require 'open-uri'

class ProcessedStat < ApplicationRecord
  def self.procssALLData
    currentDate = Time.now.strftime("%Y%m%d")

    RawStat.all.each { |obj| 
      ProcessedStat.create(
        state_id: State.find_by(state_abbreviation: obj.state).id, 
        date: obj.date, 
        positive: obj.positive, 
        negative: obj.negative, 
        pending: obj.pending, 
        deah: obj.death, 
        total: obj.total, 
        dateChecked: obj.dateChecked
      )
    }
    
  end 

  def self.processDaysData
    currentDate = Time.now.strftime("%Y%m%d")

    RawStat.where(date: currentDate).each { |obj| 
    ProcessedStat.create(
      state_id: State.find_by(state_abbreviation: obj.state).id, 
      date: obj.date, 
      positive: obj.positive, 
      negative: obj.negative, 
      pending: obj.pending, 
      deah: obj.death, 
      total: obj.total, 
      dateChecked: obj.dateChecked
    )
  }
  end 

  

end
