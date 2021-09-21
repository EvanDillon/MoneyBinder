Rails.application.routes.draw do
  root to: 'sessions#welcome'
  resources :users, only: [:new, :create]

  scope '', controller: 'sessions' do
    post 'login/', action: 'login'
    get 'welcome/', action: 'welcome'
    get 'homepage/', action: 'homepage'
    get 'user_management/', action: 'user_management'
    get 'create/', action: 'create'
    get 'profile/', action: 'profile'
    get 'logout/', action: 'destroy'
    delete 'logout/', action: 'destroy'
  end

  get 'user/destroy/:id', to: 'users#destroy'
  get 'user/edit/:id', to: 'users#edit'
  post 'user/edit/:id', to: 'users#edit'
  get 'user/update/:id', to: 'users#update'
  post 'user/update', to: 'users#update'
  get 'user/create', to: 'users#create'
  post 'user/create', to: 'users#create'

  scope 'password/', controller: 'password' do 
    get 'reset/', action: 'reset'
    post 'reset/', action: 'reset'
    get 'forgot/', action: 'forgot'
    post 'forgot/', action: 'forgot'
  end
end
