Rails.application.routes.draw do
  root to: 'sessions#welcome'
  resources :users, only: [:new, :create]

  scope '', controller: 'sessions' do
    post 'login/', action: 'login'
    get 'welcome/', action: 'welcome'
    get 'homepage/', action: 'homepage'
    get 'user_management/', action: 'user_management'
  end

  scope 'password/', controller: 'password' do 
    get 'reset/', action: 'reset'
    post 'reset/', action: 'reset'
    get 'forgot/', action: 'forgot'
    post 'forgot/', action: 'forgot'
  end
end
