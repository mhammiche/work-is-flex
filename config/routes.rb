# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  resources :booking_requests, only: %i[new create show]
end
