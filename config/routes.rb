Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      get '/search-cep/:cep', to: 'ceps#search_cep'
    end
  end
end
