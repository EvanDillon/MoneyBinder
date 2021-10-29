Rails.application.routes.draw do
  # resources :ledger_entries
  resources :journal_entries
  resources :event_logs
  root to: 'sessions#welcome'
  resources :users
  resources :accounts

  scope '', controller: 'sessions' do
    post 'login/', action: 'login'
    get 'welcome/', action: 'welcome'
    get 'homepage/', action: 'homepage'
    get 'user_management/', action: 'user_management'
    get 'sign_up/', action: 'sign_up'
    post 'process_new_sign_up/', action: 'process_new_sign_up'
    get 'profile/', action: 'profile'
    get 'expired_passwords/', action: 'expired_passwords'
    get 'send_message/', action: 'send_message'
    get 'logout/', action: 'destroy'
    delete 'logout/', action: 'destroy'
    get 'journal/', action: 'journal'
    get '/help_index', action: 'help_index'
    get '/sign_in_help', action: 'sign_in_help'
    get '/user_management_help', action: 'user_management_help'
    get '/event_logs_help', action: 'event_logs_help'
    get '/error', action: 'error'
  end

  get 'user/destroy/:id', to: 'users#destroy'
  get 'user/edit/:id', to: 'users#edit'
  post 'user/edit/:id', to: 'users#edit'
  get 'user/update/:id', to: 'users#update'
  post 'user/update', to: 'users#update'
  get 'user/create', to: 'users#create'
  post 'user/create', to: 'users#create'
  get 'administrator/email', to: 'users#administrator_email'
  post 'administrator/email', to: 'users#administrator_email'
  post '/approve', to: 'journal_entries#approve'
  post '/decline', to: 'journal_entries#decline'
  get 'ledger/:account_id', to: 'ledger_entries#show'
  get '/journal_entry/:id', to: 'journal_entries#show'

  scope 'password/', controller: 'password' do 
    get 'reset/', action: 'reset'
    post 'reset/', action: 'reset'
    get 'forgot/', action: 'forgot'
    post 'forgot/', action: 'forgot'
  end

end
