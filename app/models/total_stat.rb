require 'open-uri'

class TotalStat < ApplicationRecord
  @@currentDate = Time.now.strftime("%Y%m%d").to_i
  @@allDatesArr = RawStat.distinct.pluck("date").sort
  # @@allDatesArr = [20200317, 20200318]
  # @@allDatesArr.pop
  @@allStatesArr = RawStat.distinct.pluck("state").sort  - ["AS", "VI", "GU", "MP"]
  # @@allStatesArr.push("AS", "VI", "GU", "MP")
  # @@allStatesArr = ["AL", "AR", "AK"]
  @@allCountTypesArr = [ "positive", "negative", "pending", "death", "total"]
  
  # belongs_to :state
  
  def self.daily5pProcessingCron
    if !@@allDatesArr.include?(@@currentDate)
      RawStat.pullAndProcessDaysData([@@currentDate])
      self.addTotalStatToAppropriateRecord([@@currentDate])  
      self.addNEWStatToAppropriateRecord([@@currentDate])
    end ## ends if checking to see if current date is already in raw DB
  end
  
  def self.bulkDataPullAndUpdate(arrOfDatesToProcess)
      RawStat.pullAndProcessDaysData(arrOfDatesToProcess) && self.addTotalStatToAppropriateRecord(arrOfDatesToProcess) && self.addNEWStatToAppropriateRecord(arrOfDatesToProcess)
  end
  
  def self.createDbRowsForStateNewAndTotalCombos
    ### Creates one record per State + TotalCount Type combo (for both TOTAL and NEW nubmers)
    ## Does not fetch data
    for state in @@allStatesArr do
      for t in @@allCountTypesArr do
        ProcessedStat.create(state_id: State.find_by(state_abbreviation: state).id, count_type: "#{"total-" + t}")
        if t != "pending"
          ProcessedStat.create(state_id: State.find_by(state_abbreviation: state).id, count_type: "#{"new-" + t}")
        end
      end
    end
  end


  def self.processALLData
    ### Creates one record per State + TotalCount Type combo (for both TOTAL and NEW nubmers)
    ## Does not fetch data
    self.createDbRowsForStateNewAndTotalCombos
    #### Adds the TOTAL stat to the appropriate record and date intersection for TOTAL numbers   
    self.addTotalStatToAppropriateRecord(@@allDatesArr)  
    #### Adds the NEW stat to the appropriate record and date intersection for NEW numbers   
    self.addNEWStatToAppropriateRecord(@@allDatesArr)  
  end ## ends processALLData function
  
  def self.processALLDataWithoutCreatingNewRows
    #### Adds the TOTAL stat to the appropriate record and date intersection for TOTAL numbers   
    self.addTotalStatToAppropriateRecord(@@allDatesArr)  
    #### Adds the NEW stat to the appropriate record and date intersection for NEW numbers   
    self.addNEWStatToAppropriateRecord(@@allDatesArr)  
  end ## ends processALLData function

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
        for typObj in @@allCountTypesArr do
          if typObj != "pending"
            ## First block gathers newCountVal
            ## Checks to see if current day is the first in @@the array
            if d === @@allDatesArr[0]
              newCountVal = ProcessedStat.find_by(state_id: State.find_by(state_abbreviation: "#{s}").id, count_type: "#{"total-" + typObj}")[d]
            else
              previousDate = @@allDatesArr[@@allDatesArr.index(d - 1)]
              previousDateCount = ProcessedStat.find_by(state_id: State.find_by(state_abbreviation: "#{s}").id, count_type: "#{"total-" + typObj}")[previousDate]
              if !!previousDateCount 
                currentDateCount = ProcessedStat.find_by(state_id: State.find_by(state_abbreviation: "#{s}").id, count_type: "#{"total-" + typObj}")[d]
                if !currentDateCount
                  currentDateCount = previousDateCount
                end
                newCountVal = currentDateCount - previousDateCount
              else 
                newCountVal = ProcessedStat.find_by(state_id: State.find_by(state_abbreviation: "#{s}").id, count_type: "#{"total-" + typObj}")[d]
              end ## ends IF related to Current Date Count being nil
            end ## Ends if statement checking to see if d is the first day in @@array
            if !!newCountVal
              recToUpdate = ProcessedStat.find_by(state_id: State.find_by(state_abbreviation: "#{s}").id, count_type: "#{"new-" + typObj}")
              recToUpdate.update( "#{d}": newCountVal )
            end ## ends newCountVal IF statement
          end ## ends IF only procssing non-pending types
        end ## ends allCountTypesArr each loop
      end ## ends allDatesArr each loop
    end ## ends allStatesArr each loop
  end ## ends addTotalStatToAppropriateRecord method



end
