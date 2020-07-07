# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'feishu/oauth_callback', to: 'feishu/oauth_callbacks#show'
  post 'feishu/messages/receive', to: 'feishu/messages#receive'

  namespace :feishu do
    resources :events, only: :create
  end
end
