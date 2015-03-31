Rails.application.routes.draw do
  root to: 'constraint_week_templates#index'

  resources :constraint_days
  resources :constraint_week_templates

end
