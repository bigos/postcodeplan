Rails.application.routes.draw do
  resources :addresses

  root 'addresses#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
