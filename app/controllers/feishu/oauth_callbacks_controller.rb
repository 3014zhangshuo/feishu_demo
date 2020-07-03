# frozen_string_literal: true

module Feishu
  class OauthCallbacksController < ApplicationController
    before_action :set_oauth

    def show
      render json: { **@oauth.user_info, openid: @oauth.openid }
    end

    private

    def set_oauth
      @oauth = ::Feishu::Oauth.new(params[:code])
    end
  end
end
