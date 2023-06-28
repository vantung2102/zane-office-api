# == Route Map
#

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root 'supports#home'

  namespace :api do
    namespace :v1 do
      namespace :auth do
        post :signup, to: 'registrations#create'
        post :verify, to: 'registrations#verify'

        post :login, to: 'sessions#log_in'
      end
    end
  end
end
