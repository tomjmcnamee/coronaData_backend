class Api::V1::ProcessedStatController < ApplicationController


    
    def indexTotal ##COMBINED --- SINGLE DB CALL
        if request.headers["FetchPW"] === ENV["FETCH_PASSWORD"]
            if request.headers["numOfDays"] === "all"
                allDatesArr = (RawStat.distinct.pluck("date") | ENV["ALL_DATES_ARR"].split(",").map(&:to_i)).sort.reverse
                allTOTALStats = ProcessedStat.all.sort { |x,y| x.state_id <=> y.state_id }
            else
                # debugger
                allDatesArr = (RawStat.distinct.pluck("date") | ENV["ALL_DATES_ARR"].split(",").map(&:to_i)).sort.reverse.first(request.headers["numOfDays"].to_i + 1)
                filteredDateColumns = allDatesArr.map { |x| x.to_s.to_sym}
                allTOTALStats = ProcessedStat.all.select(:state_id, :count_type, filteredDateColumns).sort { |x,y| x.state_id <=> y.state_id }    
            end
            stayAtHomeOrders = StayAtHomeOrder.all
            dataQualityGrades = DataQualityGrade.all.select(:state_id, :grade, :state_abbreviation, :id)
            # The Below line doesnt includee NY or NJ in the returned dataset
            # allTOTALStats = ProcessedStat.all.sort { |x,y| x.state_id <=> y.state_id }.select { |obj| obj.state_id != 32 && obj.state_id != 30  }

            totalPositive , totalNegative, totalDeath, totalTotal, totalHospitalized = [], [], [], [], []
            newPositive , newNegative, newDeath, newTotal, newHospitalized = [], [],[ ], [], []
            allTOTALStats.each do |obj|
                totalPositive << obj if obj.count_type == 'total-positive'
                totalNegative << obj if obj.count_type == 'total-negative'
                totalDeath << obj if obj.count_type == 'total-death'
                totalTotal << obj if obj.count_type == 'total-total'
                totalHospitalized << obj if obj.count_type == 'total-hospitalized'
                newPositive << obj if obj.count_type == 'new-positive'
                newNegative << obj if obj.count_type == 'new-negative'
                newDeath << obj if obj.count_type == 'new-death'
                newTotal << obj if obj.count_type == 'new-total'
                newHospitalized << obj if obj.count_type == 'new-hospitalized' 
            end
            render json: {
                allDatesArr: allDatesArr,
                stayAtHomeOrders: stayAtHomeOrders,
                totalPositive:totalPositive,
                totalNegative:totalNegative,
                totalDeath: totalDeath,
                totalTotal: totalTotal,
                totalHospitalized: totalHospitalized,
                newPositive:newPositive,
                newNegative:newNegative,
                newDeath: newDeath,
                newTotal: newTotal,
                newHospitalized: newHospitalized,
                dataQualityGrades: dataQualityGrades
            } 
        end
    end




private


    
end  ## Ends class