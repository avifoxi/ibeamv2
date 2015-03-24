Rails.application.routes.draw do
  root to: 'visitors#index'

  resources :constraint_days
  resources :constraint_week_templates

end
