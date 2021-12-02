Rails.application.routes.draw do
  root to: 'sessions#welcome'
  resources :journal_entries
  resources :event_logs
  resources :user_logs
  resources :users
  resources :accounts

  scope '', controller: 'sessions' do
    post 'login/', action: 'login'
    get 'welcome/', action: 'welcome'
    get 'homepage/', action: 'homepage'
    get 'user_management/', action: 'user_management'
    get 'trial_balance/', action: 'trial_balance'
    get 'retained_earnings/', action: 'retained_earnings'
    get 'income_statement/', action: 'income_statement'
    get 'balance_sheet/', action: 'balance_sheet'

    get 'send_trial_balance/', action: 'send_trial_balance'
    get 'send_income_statement/', action: 'send_income_statement'
    get 'send_retained_earnings/', action: 'send_retained_earnings'
    get 'send_balance_sheet/', action: 'send_balance_sheet'

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
  post '/approve_all', to: 'journal_entries#approve_all'
  post '/decline_all', to: 'journal_entries#decline_all'
  get '/generate_closing_entry', to: 'journal_entries#generate_closing_entry'
  get 'ledger/:account_id', to: 'ledger_entries#show'
  get '/journal_entry/:id', to: 'journal_entries#show'
  get '/reload_page', to: 'journal_entries#reload_page'

  scope 'password/', controller: 'password' do 
    get 'reset/', action: 'reset'
    post 'reset/', action: 'reset'
    get 'forgot/', action: 'forgot'
    post 'forgot/', action: 'forgot'
  end

end
