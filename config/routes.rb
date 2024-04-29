Rails.application.routes.draw do
  devise_for :teachers
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'tops#index'

  get 'terms_of_service', to: 'terms_of_service#show'
  get 'privacy_policy', to: 'privacy_policy#show'

  # システム管理者用画面
  namespace :admin, path: 'aaaaaaaa' do
    root to: 'schools#index', as: 'root'

    devise_for :admins,
               only: %i[session password],
               controllers: { passwords: 'admins/passwords',
                              sessions: 'admins/sessions' }
    resources :schools do
      resources :student_classes, param: :code, only: %i[show new create edit update destroy]
      resources :teachers, param: :code, only: %i[show new create edit update destroy]
    end
  end
end
