require 'open-uri'

class TotalStat < ApplicationRecord
  @@currentDate = Time.now.strftime("%Y%m%d").to_i
  @@allDatesArr = (RawStat.distinct.pluck("date") | [20200707,20200706,20200705,20200704,20200703,20200702,20200701,20200630,20200629,20200628,20200627,20200626,20200625,20200624,20200623,20200622,20200621,20200620,20200619,20200618,20200617,20200616,20200615,20200614,20200613,20200612,20200611,20200610,20200609,20200608,20200607,20200606,20200605,20200604,20200603,20200602,20200601,20200531,20200530,20200529,20200528,20200527,20200526,20200525,20200524,20200523,20200522,20200521,20200520,20200519,20200518,20200517,20200516,20200515,20200514,20200513,20200512,20200511,20200510,20200509,20200508,20200507,20200506,20200505,20200504,20200503,20200502,20200501,20200430,20200429,20200428,20200427,20200426,20200425,20200424,20200423,20200422,20200421,20200420,20200419,20200418,20200417,20200416,20200415,20200414,20200413,20200412,20200411,20200410,20200409,20200408,20200407,20200406,20200405,20200404,20200403,20200402,20200401,20200331,20200330,20200329,20200328,20200327,20200326,20200325,20200324,20200323,20200322,20200321,20200320,20200319,20200318,20200317,20200316,20200315,20200314,20200313,20200312,20200311,20200310,20200309,20200308,20200307,20200306,20200305,20200304,20200303,20200302,20200301,20200229,20200228]).sort
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
