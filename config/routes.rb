Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      
      
      get '/processed_stats', to: "processed_stat#index"
      get '/states', to: "state#index"
      get '/daily_5p_update', to: "db_update#Daily5pUpdate"
      # patch '/bulk_load_arr_of_dates', to: "db_update#BulkLoadDatesData"
      patch '/bulk_load_arr_of_dates/:dates', to: "db_update#BulkLoadDatesData"
     
    end
  end
end
