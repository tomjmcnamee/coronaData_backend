class Api::V1::DbUpdateController < ApplicationController

    # updateLogger = updateLogger ||=Logger.new("#{Rails.root}/log/UpdateFetch.log")


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
        allDatesArr = RawStat.distinct.pluck("date").sort
        currentDate = Time.now.strftime("%Y%m%d").to_i
        
        #### These 2 lines ensure that 7 days worth of data is updated each day
        indexFrom7DaysAgo = ProcessedStat.column_names.find_index(currentDate.to_s) - 6
        arrOfDatesToProcess = ProcessedStat.column_names[indexFrom7DaysAgo, 7].map(&:to_i)
        # yesterday = (Time.now - 1.day).strftime("%Y%m%d").to_i
        if request.headers["DailyUpdate"] === ENV["DAILYUPDATE_PASSWORD"]
            if !allDatesArr.include?(currentDate)
                RawStat.pullAndProcessDaysData(arrOfDatesToProcess) &&
                TotalStat.addNEWStatToAppropriateRecord(arrOfDatesToProcess)  &&
                TotalStat.addTotalStatToAppropriateRecord(arrOfDatesToProcess)   &&
                DataQualityGrade.addDataQualityStatToAppropriateRecord([currentDate])
            end
            render json: {  status: "Ran Successfully - If API data available, it was added"  }
            # updateLogger.info {"Successful PATCH for daily5pUpdate from (HTTP_Origin) #{request.headers['HTTP_ORIGIN'].inspect}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}   "}
        else
            # updateLogger.error { "Bad PATCH PW attempt for daily5pUpdate  from (HTTP_Origin) #{request.headers['HTTP_ORIGIN}']}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}  "}
        end  ## Ends IF STatement about fetch password  
    end  # Ends Daily5pUpdate method
    
    def BulkLoadDatesData
        # updateLogger = updateLogger ||=Logger.new("#{Rails.root}/log/UpdateFetch.log")
        if request.headers["BulkLoad"] === ENV["BULKLOAD_PASSWORD"]
            datesArr = request.headers["DatesArr"].split(",").map { |date| date.to_i }
            # datesArr = request.params[:dates].split(",").map { |date| date.to_i }
            # TotalStat.bulkDataPullAndUpdate([datesArr])
            RawStat.pullAndProcessDaysData(datesArr)
            TotalStat.addTotalStatToAppropriateRecord(datesArr)  
            TotalStat.addNEWStatToAppropriateRecord(datesArr)
            DataQualityGrade.addDataQualityStatToAppropriateRecord(datesArr)
            
            # updateLogger.info {"Successful PATCH for BulkLoadDatesData from (HTTP_Origin) #{request.headers['HTTP_ORIGIN'].inspect}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}   "}
            render json: {  status: "Success: Data For the passed Dates Array has been pulled and Added"  }
        else
            # updateLogger.error { "Bad PATCH PW attempt for BulkLoadDatesData  from (HTTP_Origin) #{request.headers['HTTP_ORIGIN}']}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}  "}
        end  ## Ends IF STatement about fetch password  
    end  # Ends BulkLoadDatesData method
    
    def refreshAllData
        # updateLogger = updateLogger ||=Logger.new("#{Rails.root}/log/UpdateFetch.log")
        timeStart = Time.now
        if request.headers["RefreshData"] === ENV["REFRESHDATA_PASSWORD"]
            RawStat.delete_all
            RawStat.pullALLData
            TotalStat.processALLDataWithoutCreatingNewRows
            DataQualityGrade.addDataQualityStatToAppropriateRecord([RawStat.maximum(:date)])
            
            # updateLogger.info {"Successful PATCH for BulkLoadDatesData from (HTTP_Origin) #{request.headers['HTTP_ORIGIN'].inspect}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}   "}
            render json: {  status: "Success: All Data Refreshed"  }
        else
            # updateLogger.error { "Bad PATCH PW attempt for BulkLoadDatesData  from (HTTP_Origin) #{request.headers['HTTP_ORIGIN}']}   (HTTP_REFERER) #{request.headers['HTTP_REFERER']}  "}
        end  ## Ends IF STatement about fetch password  
        totalSeconds = Time.now - timeStart
        puts "Total Time = #{Time.at(totalSeconds).utc.strftime("%H:%M:%S")}"
    end  # Ends BulkLoadDatesData method

    



private


    
end  ## Ends class