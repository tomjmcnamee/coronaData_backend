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
        timeStart = Time.now
        allDatesArr = (RawStat.distinct.pluck("date") | [20200707,20200706,20200705,20200704,20200703,20200702,20200701,20200630,20200629,20200628,20200627,20200626,20200625,20200624,20200623,20200622,20200621,20200620,20200619,20200618,20200617,20200616,20200615,20200614,20200613,20200612,20200611,20200610,20200609,20200608,20200607,20200606,20200605,20200604,20200603,20200602,20200601,20200531,20200530,20200529,20200528,20200527,20200526,20200525,20200524,20200523,20200522,20200521,20200520,20200519,20200518,20200517,20200516,20200515,20200514,20200513,20200512,20200511,20200510,20200509,20200508,20200507,20200506,20200505,20200504,20200503,20200502,20200501,20200430,20200429,20200428,20200427,20200426,20200425,20200424,20200423,20200422,20200421,20200420,20200419,20200418,20200417,20200416,20200415,20200414,20200413,20200412,20200411,20200410,20200409,20200408,20200407,20200406,20200405,20200404,20200403,20200402,20200401,20200331,20200330,20200329,20200328,20200327,20200326,20200325,20200324,20200323,20200322,20200321,20200320,20200319,20200318,20200317,20200316,20200315,20200314,20200313,20200312,20200311,20200310,20200309,20200308,20200307,20200306,20200305,20200304,20200303,20200302,20200301,20200229,20200228]).sort
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

                totalSeconds = Time.now - timeStart
                puts "----- Total Time for Daily Update on #{currentDate} = #{Time.at(totalSeconds).utc.strftime("%H:%M:%S")}"        
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
        puts "----- Total Time for RefreshingAllData on #{currentDate} = #{Time.at(totalSeconds).utc.strftime("%H:%M:%S")}"        
    end  # Ends BulkLoadDatesData method

    



private


    
end  ## Ends class