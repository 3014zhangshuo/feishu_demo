# frozen_string_literal: true

module Feishu
  class OauthCallbacksController < ApplicationController
    before_action :set_oauth

    def show
      render json: { openid: @oauth.openid, **@oauth.user_info }
    end

    private

    def set_oauth
      @oauth = ::Feishu::Oauth.new(params[:code])
    end
  end
end
