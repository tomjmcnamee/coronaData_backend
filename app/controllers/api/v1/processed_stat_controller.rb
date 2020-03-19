class Api::V1::ProcessedStatController < ApplicationController
    def index  
        allDatesArr = RawStat.distinct.pluck("date").sort
        allStats = ProcessedStat.all
        # debugger
        render json: {
            # allStats: allStats.as_json(include: [:state])  ## ~3.5 seconds processing
            allStats: allStats,    ##comparted to ~.5 seconds processing
            allDatesArr: allDatesArr
       
       
        }   

        
    end



private


    
end