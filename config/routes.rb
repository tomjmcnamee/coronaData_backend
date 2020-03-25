Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      
      
      get '/total_stats', to: "processed_stat#indexTotal"
      get '/new_stats', to: "processed_stat#indexNew"
      get '/states', to: "state#index"
      patch '/daily_5p_update', to: "db_update#Daily5pUpdate"
      patch '/bulk_load_arr_of_dates', to: "db_update#BulkLoadDatesData"
      patch '/refresh_data', to: "db_update#refreshAllData"
      # patch '/bulk_load_arr_of_dates/:dates', to: "db_update#BulkLoadDatesData"
     
    end
  end
end
