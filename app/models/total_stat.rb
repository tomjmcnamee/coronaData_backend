require 'open-uri'

class TotalStat < ApplicationRecord
  @@currentDate = Time.now.strftime("%Y%m%d").to_i
  @@allDatesArr = (RawStat.distinct.pluck("date") | ENV["ALL_DATES_ARR"].split(",").map(&:to_i)).sort
  # @@allDatesArr = [20200317, 20200318]
  # @@allDatesArr.pop
  @@allStatesArr = RawStat.distinct.pluck("state").sort  - ["AS", "VI", "GU", "MP"]
  @@allCountTypesArr = [ "positive", "negative", "death", "total", "hospitalized"]
  @@newCountTypesArr = [ "deathIncrease","negativeIncrease","positiveIncrease", "hospitalizedIncrease", "totalTestResultsIncrease"]
 


  # belongs_to :state
  
  def self.daily5pProcessingCron
    if !@@allDatesArr.include?(@@currentDate)
      RawStat.pullAndProcessDaysData([@@currentDate])
      self.addTotalStatToAppropriateRecord([@@currentDate])  
      self.addNEWStatToAppropriateRecord([@@currentDate])
    end ## ends if checking to see if current date is already in raw DB
  end
  
  def self.bulkDataPullAndUpdate(arrOfDatesToProcess)
      RawStat.pullAndProcessDaysData(arrOfDatesToProcess) && 
      self.addTotalStatToAppropriateRecord(arrOfDatesToProcess) && 
      self.addNEWStatToAppropriateRecord(arrOfDatesToProcess)
  end


  
  def self.processALLDataWithoutCreatingNewRows
    self.addTotalStatToAppropriateRecord(@@allDatesArr)  && 
    self.addNEWStatToAppropriateRecord(@@allDatesArr)      
  end ## ends processAprocessALLDataWithoutCreatingNewRowsLLData function

  def self.addTotalStatToAppropriateRecord(arrOfDatesToProcess)  
    for s in @@allStatesArr do
      for d in arrOfDatesToProcess do
        for typObj in @@allCountTypesArr do
          tempObj = RawStat.find_by(date: "#{d}", state: "#{s}" )
          if !!tempObj
            tempval = tempObj[typObj]
            if !!tempval
              recToUpdate = ProcessedStat.find_by(state_id: State.find_by(state_abbreviation: "#{s}").id, count_type: "#{"total-" + typObj}")
              recToUpdate.update( "#{d}": tempval )
            end ## ends tempval IF statement
          end ## ends tempObj IF statement
        end ## ends allCountTypesArr each loop
      end ## ends allDatesArr each loop
    end ## ends allStatesArr each loop
  end ## ends addTotalStatToAppropriateRecord method
  
  
  def self.addNEWStatToAppropriateRecord(arrOfDatesToProcess)  
    for s in @@allStatesArr do
      for d in arrOfDatesToProcess do
        for typObj in @@newCountTypesArr do
          tempObj = RawStat.find_by(date: "#{d}", state: "#{s}" )
          if !!tempObj
            tempval = tempObj[typObj]
            if !!tempval
              if typObj == "totalTestResultsIncrease"
                recToUpdate = ProcessedStat.find_by(state_id: State.find_by(state_abbreviation: "#{s}").id, count_type: "new-total")
              else
                recToUpdate = ProcessedStat.find_by(state_id: State.find_by(state_abbreviation: "#{s}").id, count_type: "#{"new-" + typObj.chomp('Increase')}")
              end
              if !! recToUpdate
                recToUpdate.update( "#{d}": tempval )
              end
            end ## ends tempval IF statement
          end ## ends tempObj IF statement
        end ## ends newCountTypesArr each loop
      end ## ends allDatesArr each loop
    end ## ends allStatesArr each loop
  end ## ends addTotalStatToAppropriateRecord method




end
