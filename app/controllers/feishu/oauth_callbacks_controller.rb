# frozen_string_literal: true

module Feishu
  class OauthCallbacksController < ApplicationController
    before_action :set_oauth

    def show
      if user
        sign_in(user)
      else
        session[:user_provider_info] = @oauth.info
      end

      redirect_to root_path
    end

    private

    def user
      UserProvider.find_by_openid(@oauth.info['openid'])&.user
    end

    def set_oauth
      @oauth = ::Feishu::Oauth.new(params[:code])
    end
  end
end
