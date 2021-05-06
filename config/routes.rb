Rails.application.routes.draw do
  root to: 'customers#index'  
  #The line above will configure the server to bring up this page when you connect to the root path.
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
