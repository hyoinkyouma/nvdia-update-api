Rails.application.routes.draw do
  resources :nvidia, only: [:index]
  resources :form, path:'/', only: [:index]
end
