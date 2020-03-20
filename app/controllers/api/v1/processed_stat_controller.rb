class Api::V1::ProcessedStatController < ApplicationController
    def index  
        allDatesArr = RawStat.distinct.pluck("date").sort
        allNEWStats = ProcessedStat.where("count_type LIKE ?", "new-%")
        newPositive = allNEWStats.where(count_type: "new-positive")
        newNegative = allNEWStats.where(count_type: "new-negative")
        newDeath = allNEWStats.where(count_type: "new-death")
        newTotal = allNEWStats.where(count_type: "new-total")

        allTOTALStats = ProcessedStat.where("count_type LIKE ?", "total-%")
        totalPositive = allTOTALStats.where(count_type: "total-positive")
        totalNegative = allTOTALStats.where(count_type: "total-negative")
        totalPending = allTOTALStats.where(count_type: "total-pending")
        totalDeath = allTOTALStats.where(count_type: "total-death")
        totalTotal = allTOTALStats.where(count_type: "total-total")



        # debugger
        render json: {
            allDatesArr: allDatesArr,
            # allTOTALStats:allTOTALStats,
            # allNEWStats: allNEWStats,
            newPositive:newPositive,
            newNegative:newNegative,
            newDeath: newDeath,
            newTotal: newTotal,
            totalPositive:totalPositive,
            totalNegative:totalNegative,
            totalPending:totalPending,
            totalDeath: totalDeath,
            totalTotal: totalTotal
        }   

        
    end



private


    
end