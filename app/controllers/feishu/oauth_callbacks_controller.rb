# frozen_string_literal: true

module Feishu
  class OauthCallbacksController < ApplicationController
    def show
      render json: get_user_info
    end

    private

    def code
      params[:code]
    end

    def app_access_token
      @app_access_token ||= begin
        r_params = {
          app_id: "cli_9e7688822c74500c",
          app_secret: "6HxTE1njNUCG5OsxEpESwdJbTGWpHnJT",
        }
        result = RestClient.post "https://open.feishu.cn/open-apis/auth/v3/app_access_token/internal/", r_params.to_json, {content_type: :json, accept: :json}
        Rails.logger.debug "app_access_token--------#{result}"
        JSON.parse(result)["app_access_token"]
      end
    end

    def get_access_token
      @get_access_token ||= begin
        r_params = {
          app_access_token: app_access_token,
          grant_type: "authorization_code",
          code: code
        }
        result = RestClient.post "https://open.feishu.cn/open-apis/authen/v1/access_token", r_params.to_json, {content_type: :json, accept: :json}
        Rails.logger.debug "get_access_token--------#{result}"
        result
      end
    end

    def user_access_token
      JSON.parse(get_access_token)["data"]["access_token"]
    end

    def get_user_info
      @get_user_info ||= begin
        r_params = {
          user_access_token: user_access_token
        }
        result = RestClient.get "https://open.feishu.cn/open-apis/authen/v1/user_info", { params: r_params }
        Rails.logger.debug "get_user_info--------#{result}"
        result
      end
    end
  end
end
