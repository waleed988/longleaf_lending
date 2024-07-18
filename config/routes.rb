Rails.application.routes.draw do
  root 'leads#new', as: 'home'
  resources :leads, only: [:new, :create] 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
