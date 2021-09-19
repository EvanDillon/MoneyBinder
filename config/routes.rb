Rails.application.routes.draw do
  root to: 'sessions#welcome'
  resources :users, only: [:new, :create]

  scope '', controller: 'sessions' do
    post 'login/', action: 'login'
    get 'welcome/', action: 'welcome'
    get 'homepage/', action: 'homepage'
    get 'password_reset/', action: 'password_reset'
    post 'password_reset/', action: 'password_reset'
    get 'user_management/', action: 'user_management'
  end
end
