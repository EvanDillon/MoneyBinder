Rails.application.routes.draw do
  root to: 'sessions#welcome'
  resources :users, only: [:new, :create]

  scope '', controller: 'sessions' do
    post 'login/', action: 'login'
    get 'welcome/', action: 'welcome'
    get 'authorized/', action: 'page_requires_login'
    get 'password_reset/', action: 'password_reset'
  end
end
