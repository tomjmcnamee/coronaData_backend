class Api::V1::ProcessedStatController < ApplicationController


    
    def indexTotal ##COMBINED --- SINGLE DB CALL
        if request.headers["FetchPW"] === ENV["FETCH_PASSWORD"]
            if request.headers["numOfDays"] === "all"
                allDatesArr = (RawStat.distinct.pluck("date") | [20200707,20200706,20200705,20200704,20200703,20200702,20200701,20200630,20200629,20200628,20200627,20200626,20200625,20200624,20200623,20200622,20200621,20200620,20200619,20200618,20200617,20200616,20200615,20200614,20200613,20200612,20200611,20200610,20200609,20200608,20200607,20200606,20200605,20200604,20200603,20200602,20200601,20200531,20200530,20200529,20200528,20200527,20200526,20200525,20200524,20200523,20200522,20200521,20200520,20200519,20200518,20200517,20200516,20200515,20200514,20200513,20200512,20200511,20200510,20200509,20200508,20200507,20200506,20200505,20200504,20200503,20200502,20200501,20200430,20200429,20200428,20200427,20200426,20200425,20200424,20200423,20200422,20200421,20200420,20200419,20200418,20200417,20200416,20200415,20200414,20200413,20200412,20200411,20200410,20200409,20200408,20200407,20200406,20200405,20200404,20200403,20200402,20200401,20200331,20200330,20200329,20200328,20200327,20200326,20200325,20200324,20200323,20200322,20200321,20200320,20200319,20200318,20200317,20200316,20200315,20200314,20200313,20200312,20200311,20200310,20200309,20200308,20200307,20200306,20200305,20200304,20200303,20200302,20200301,20200229,20200228]).sort.reverse
                allTOTALStats = ProcessedStat.all.sort { |x,y| x.state_id <=> y.state_id }
            else
                allDatesArr = (RawStat.distinct.pluck("date") | [20200707,20200706,20200705,20200704,20200703,20200702,20200701,20200630,20200629,20200628,20200627,20200626,20200625,20200624,20200623,20200622,20200621,20200620,20200619,20200618,20200617,20200616,20200615,20200614,20200613,20200612,20200611,20200610,20200609,20200608,20200607,20200606,20200605,20200604,20200603,20200602,20200601,20200531,20200530,20200529,20200528,20200527,20200526,20200525,20200524,20200523,20200522,20200521,20200520,20200519,20200518,20200517,20200516,20200515,20200514,20200513,20200512,20200511,20200510,20200509,20200508,20200507,20200506,20200505,20200504,20200503,20200502,20200501,20200430,20200429,20200428,20200427,20200426,20200425,20200424,20200423,20200422,20200421,20200420,20200419,20200418,20200417,20200416,20200415,20200414,20200413,20200412,20200411,20200410,20200409,20200408,20200407,20200406,20200405,20200404,20200403,20200402,20200401,20200331,20200330,20200329,20200328,20200327,20200326,20200325,20200324,20200323,20200322,20200321,20200320,20200319,20200318,20200317,20200316,20200315,20200314,20200313,20200312,20200311,20200310,20200309,20200308,20200307,20200306,20200305,20200304,20200303,20200302,20200301,20200229,20200228]).sort.reverse.first(request.headers["numOfDays"].to_i + 1)
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