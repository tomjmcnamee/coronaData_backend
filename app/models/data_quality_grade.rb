class DataQualityGrade < ApplicationRecord
  belongs_to :state

  @@allStatesArr = DataQualityGrade.pluck("state_abbreviation")


  def self.addDataQualityStatToAppropriateRecord(arrOfDatesToProcess)  
    d = arrOfDatesToProcess.max
    for s in @@allStatesArr do
      tempObj = RawStat.find_by(date: "#{d}", state: "#{s}" )
      if !!tempObj
        tempval = tempObj[:grade]
        if !!tempval
          recToUpdate = DataQualityGrade.find_by(state_abbreviation: "#{s}")
          recToUpdate.update( grade: tempval )
        end ## ends tempval IF statement
      end ## ends tempObj IF statement
    end ## ends allStatesArr each loop
  end ## ends addTotalStatToAppropriateRecord method

end
