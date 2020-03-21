class Api::V1::StateController < ApplicationController
    def index  
        if request.headers["FetchPW"] === ENV["FETCH_PASSWORD"]
            allStates = State.all

            render json: {
                allStates: allStates
            }   
        end
        
    end



private


    
end