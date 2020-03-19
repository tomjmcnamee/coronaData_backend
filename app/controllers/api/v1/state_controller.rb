class Api::V1::StateController < ApplicationController
    def index  
        allStates = State.all

        render json: {
            allStates: allStates
        }   

        
    end



private


    
end