class Api::V1::DbUpdateController < ApplicationController
    # def createDbRecordsDOONLYONCE
    #     if request.headers["CreateDbRows"] === ENV["CREATEROWS_PASSWORD"]
    #         ## Creates DB Rows - 1 per state+new/TotalDataType combo
    #         if TotalStat.createDbRowsForStateNewAndTotalCombos
    #             render json: {  status: "Success: DB Rows created"  }
    #         else   
    #             render json: {  status: "ERROR: DB Rows NOT created"  }
    #         end # Ends IF Statement about creating the DB rows
    #     else 
    #         ## Send WRONG PW Attempt to logs
    #     end  ## Ends IF STatement about fetch password  
    # end  # Ends createDbRecordsDOONLYONCE method

    def Daily5pUpdate
        if request.headers["DailyUpdate"] === ENV["DAILYUPDATE_PASSWORD"]
            ## Creates DB Rows - 1 per state+new/TotalDataType combo
            TotalStat.daily5pProcessingCron
            render json: {  status: "Success: Days Data Added"  }
        else 
            ## Send WRONG PW Attempt to logs
        end  ## Ends IF STatement about fetch password  
    end  # Ends Daily5pUpdate method
    
    def BulkLoadDatesData
        if request.headers["BulkLoad"] === ENV["BULKLOAD_PASSWORD"]
            datesArr = request.headers["DatesArr"].split(",").map { |date| date.to_i }
            TotalStat.bulkDataPullAndUpdate(datesArr)
            render json: {  status: "Success: Data For the passed Dates Array has been pulled and Added"  }
        else 
            ## Send WRONG PW Attempt to logs
        end  ## Ends IF STatement about fetch password  
    end  # Ends BulkLoadDatesData method

    



private


    
end  ## Ends class