# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  root 'home#index'
  resources :booking_requests, only: %i[new create show] do
    member do
      get :confirm
      post :sign
      post :renew
    end
  end

  namespace :admin do
    resources :booking_requests, only: :index do
      member do
        post :accept
        post :decline
      end
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
