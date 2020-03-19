Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      
      
      get '/processed_stats', to: "processed_stat#index"
     
    end
  end
end
