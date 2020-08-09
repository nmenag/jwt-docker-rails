Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resource :sessions, only: %i[create destroy]
    resources :users
    resource :profile, only: :show
  end
end
