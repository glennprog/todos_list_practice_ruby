Rails.application.routes.draw do
  get '/' => 'application#home' 
  get '/home' => 'application#home'
  resources :todos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
