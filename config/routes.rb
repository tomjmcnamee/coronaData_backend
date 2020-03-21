Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      
      
      get '/processed_stats', to: "processed_stat#index"
      get '/states', to: "state#index"
      # get '/create_db_records_do_only_once', to: "db_update#createDbRecordsDOONLYONCE"
      get '/daily_5p_update', to: "db_update#Daily5pUpdate"
      patch '/bulk_load_arr_of_dates', to: "db_update#BulkLoadDatesData"
     
    end
  end
end
