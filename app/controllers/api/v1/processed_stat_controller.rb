class Api::V1::ProcessedStatController < ApplicationController


    # def indexTotal ##COMBINED --- MULTIPLE DB CALLS
    #     if request.headers["FetchPW"] === ENV["FETCH_PASSWORD"]
    #         allDatesArr = RawStat.distinct.pluck("date").sort.reverse
    #         stayAtHomeOrders = StayAtHomeOrder.all
    #             totalPositive = ProcessedStat.where(count_type: "total-positive").sort { |x,y| x.state_id <=> y.state_id }
    #             totalNegative = ProcessedStat.where(count_type: "total-negative").sort { |x,y| x.state_id <=> y.state_id }
    #             totalDeath = ProcessedStat.where(count_type: "total-death").sort { |x,y| x.state_id <=> y.state_id }
    #             totalTotal = ProcessedStat.where(count_type: "total-total").sort { |x,y| x.state_id <=> y.state_id }
    #             totalHospitalized = ProcessedStat.where(count_type: "total-hospitalized").sort { |x,y| x.state_id <=> y.state_id }
    #             newPositive = ProcessedStat.where(count_type: "new-positive").sort { |x,y| x.state_id <=> y.state_id }
    #             newNegative = ProcessedStat.where(count_type: "new-negative").sort { |x,y| x.state_id <=> y.state_id }
    #             newDeath = ProcessedStat.where(count_type: "new-death").sort { |x,y| x.state_id <=> y.state_id }
    #             newTotal = ProcessedStat.where(count_type: "new-total").sort { |x,y| x.state_id <=> y.state_id }
    #             newHospitalized = ProcessedStat.where(count_type: "new-hospitalized").sort { |x,y| x.state_id <=> y.state_id }
    #             render json: {
    #                 allDatesArr: allDatesArr,
    #                 totalPositive:totalPositive,
    #                 totalNegative:totalNegative,
    #                 totalDeath: totalDeath,
    #                 totalTotal: totalTotal,
    #                 totalHospitalized: totalHospitalized,
    #                 newPositive:newPositive,
    #                 newNegative:newNegative,
    #                 newDeath: newDeath,
    #                 newTotal: newTotal,
    #                 newHospitalized: newHospitalized,
    #                 stayAtHomeOrders: stayAtHomeOrders
    #             }   

    #     end
    # end
    
    
    def indexTotal ##COMBINED --- SINGLE DB CALL
        if request.headers["FetchPW"] === ENV["FETCH_PASSWORD"]
            allDatesArr = RawStat.distinct.pluck("date").sort.reverse
            stayAtHomeOrders = StayAtHomeOrder.all

            allTOTALStats = ProcessedStat.all.sort { |x,y| x.state_id <=> y.state_id }
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
                newHospitalized: newHospitalized
            } 
        end
    end



    # def indexTotal  
    #     # updateLogger = updateLogger ||=Logger.new("#{Rails.root}/log/UpdateFetch.log")
    #     # config.updateLogger = Logger.new(STDOUT)

    #     if request.headers["FetchPW"] === ENV["FETCH_PASSWORD"]
    #         allDatesArr = RawStat.distinct.pluck("date").sort.reverse
            
    #         # allTOTALStats = ProcessedStat.where("count_type LIKE ?", "total-%").sort { |x,y| x.state_id <=> y.state_id }
    #         # totalPositive , totalNegative, totalDeath, totalTotal, totalHospitalized = [], [], [], [], []
    #         # allTOTALStats.each do |obj|
    #         #     totalPositive << obj if obj.count_type == 'total-positive'
    #         #     totalNegative << obj if obj.count_type == 'total-negative'
    #         #     totalDeath << obj if obj.count_type == 'total-death'
    #         #     totalTotal << obj if obj.count_type == 'total-total'
    #         #     totalHospitalized << obj if obj.count_type == 'total-hospitalized'
    #         # end # Ends EACH Loop
            

    #             totalPositive = ProcessedStat.where(count_type: "total-positive").sort { |x,y| x.state_id <=> y.state_id }
    #             totalNegative = ProcessedStat.where(count_type: "total-negative").sort { |x,y| x.state_id <=> y.state_id }
    #             totalDeath = ProcessedStat.where(count_type: "total-death").sort { |x,y| x.state_id <=> y.state_id }
    #             totalTotal = ProcessedStat.where(count_type: "total-total").sort { |x,y| x.state_id <=> y.state_id }
    #             totalHospitalized = ProcessedStat.where(count_type: "total-hospitalized").sort { |x,y| x.state_id <=> y.state_id }




    #         render json: {
    #             allDatesArr: allDatesArr,
    #             totalPositive:totalPositive,
    #             totalNegative:totalNegative,
    #             totalDeath: totalDeath,
    #             totalTotal: totalTotal,
    #             totalHospitalized: totalHospitalized
    #         }   
    #         # updateLogger.info {"Successful GET fetch from (HTTP_Origin) #{request.headers['HTTP_ORIGIN'].inspect}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}   "}
    #     else
    #         # updateLogger.error { "Bad GET Fetch pW attempt  from (HTTP_Origin) #{request.headers['HTTP_ORIGIN}']}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}  "}
    #     end  ## Ends IF STatement about fetch password
    # end  # Ends indexTotal method


    def indexNew  
        # updateLogger = updateLogger ||=Logger.new("#{Rails.root}/log/UpdateFetch.log")

        if request.headers["FetchPW"] === ENV["FETCH_PASSWORD"]
            allNEWStats = ProcessedStat.where("count_type LIKE ?", "new-%").sort { |x,y| x.state_id <=> y.state_id }
            stayAtHomeOrders = StayAtHomeOrder.all
            newPositive , newNegative, newDeath, newTotal, newHospitalized = [], [],[ ], [], []
            allNEWStats.each do |obj|
                newPositive << obj if obj.count_type == 'new-positive'
                newNegative << obj if obj.count_type == 'new-negative'
                newDeath << obj if obj.count_type == 'new-death'
                newTotal << obj if obj.count_type == 'new-total'
                newHospitalized << obj if obj.count_type == 'new-hospitalized'
            end  # Ends EACH Loop

            
            render json: {
                newPositive:newPositive,
                newNegative:newNegative,
                newDeath: newDeath,
                newTotal: newTotal,
                newHospitalized: newHospitalized,
                stayAtHomeOrders: stayAtHomeOrders
            }   
            # updateLogger.info {"Successful GET fetch from (HTTP_Origin) #{request.headers['HTTP_ORIGIN'].inspect}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}   "}
        else
            # updateLogger.error { "Bad GET Fetch pW attempt  from (HTTP_Origin) #{request.headers['HTTP_ORIGIN}']}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}  "}
            
        end  ## Ends IF STatement about fetch password
        
    end  # Ends indexNew method





private


    
end  ## Ends class