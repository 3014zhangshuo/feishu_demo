# frozen_string_literal: true

Rails.application.routes.draw do
  get 'feishu/oauth_callback', to: 'feishu/oauth_callbacks#show'
end
