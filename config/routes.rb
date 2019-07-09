Rails.application.routes.draw do
  root 'study#index'
  post 'study/create'
  post '/user/addFunds'
  post '/user/resetBalance'
  get '/user/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
