Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope '/api' do
    resources :users
    get '/users/:id/followers', to: 'users#followers'
    post '/users/:id/follow/:target_id', to: 'users#follow'
  end
end
