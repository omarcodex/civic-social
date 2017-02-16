Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :bills
  get 'bills', to: 'bills#index'
  resources :members
  get 'members', to: 'members#index'
  resources :committees
  get 'committees', to: 'committees#index'
  root 'welcome#index'
end
