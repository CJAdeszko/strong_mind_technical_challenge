Rails.application.routes.draw do
  root 'welcome#index'

  resources :pizzas
  resources :toppings
end
