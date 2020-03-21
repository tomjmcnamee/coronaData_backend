class Api::V1::ProcessedStatController < ApplicationController

    def index  
        updateLogger = updateLogger ||=Logger.new("#{Rails.root}/log/UpdateFetch.log")

        if request.headers["FetchPW"] === ENV["FETCH_PASSWORD"]
            allDatesArr = RawStat.distinct.pluck("date").sort
            allNEWStats = ProcessedStat.where("count_type LIKE ?", "new-%").sort { |x,y| x.state_id <=> y.state_id }
            newPositive , newNegative, newDeath, newTotal = [], [],[ ], []
            allNEWStats.each do |obj|
                newPositive << obj if obj.count_type == 'new-positive'
                newNegative << obj if obj.count_type == 'new-negative'
                newDeath << obj if obj.count_type == 'new-death'
                newTotal << obj if obj.count_type == 'new-total'
            end  # Ends EACH Loop
            
            # allNEWStats = ProcessedStat.where("count_type LIKE ?", "new-%")
            # newPositive = allNEWStats.where(count_type: "new-positive").sort { |x,y| x.state_id <=> y.state_id }
            # newNegative = allNEWStats.where(count_type: "new-negative").sort { |x,y| x.state_id <=> y.state_id }
            # newDeath = allNEWStats.where(count_type: "new-death").sort { |x,y| x.state_id <=> y.state_id }
            # newTotal = allNEWStats.where(count_type: "new-total").sort { |x,y| x.state_id <=> y.state_id }

            allTOTALStats = ProcessedStat.where("count_type LIKE ?", "total-%").sort { |x,y| x.state_id <=> y.state_id }
            totalPositive , totalNegative, totalDeath, totalTotal, totalPending = [], [], [], [], []
            allTOTALStats.each do |obj|
                totalPositive << obj if obj.count_type == 'total-positive'
                totalNegative << obj if obj.count_type == 'total-negative'
                totalDeath << obj if obj.count_type == 'total-death'
                totalTotal << obj if obj.count_type == 'total-total'
                totalPending << obj if obj.count_type == 'total-pending'
            end # Ends EACH Loop

            
            
            updateLogger.info {"Successful GET fetch from (HTTP_Origin) #{request.headers['HTTP_ORIGIN'].inspect}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}   "}
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
            # debugger
        else
            updateLogger.error { "Bad GET Fetch pW attempt  from (HTTP_Origin) #{request.headers['HTTP_ORIGIN}']}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}  "}
            
        end  ## Ends IF STatement about fetch password
        
    end  # Ends index method



private


    
end  ## Ends class