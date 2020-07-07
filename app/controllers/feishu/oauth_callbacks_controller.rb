# frozen_string_literal: true

module Feishu
  class OauthCallbacksController < ApplicationController
    before_action :set_oauth

    def show
      session[:user_provider_info] = @oauth.info
      redirect_to root_path
    end

    private

    def set_oauth
      @oauth = ::Feishu::Oauth.new(params[:code])
    end
  end
end
