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

    def get_access_token
      @get_access_token ||= begin
        r_params = {
          app_id: "cli_9e7688822c74500c",
          app_secret: "6HxTE1njNUCG5OsxEpESwdJbTGWpHnJT",
          grant_type: "authorization_code",
          code: params[:code]
        }
        RestClient.post "https://open.feishu.cn/open-apis/authen/v1/access_token", r_params.to_json, {content_type: :json, accept: :json}
      end
    end

    def user_access_token
      JSON.parse(@get_access_token)["data"]["access_token"]
    end

    def get_user_info
      @get_access_token ||= begin
        r_params = {
          user_access_token: user_access_token
        }
        RestClient.post "https://open.feishu.cn/open-apis/authen/v1/user_info", r_params.to_json, {content_type: :json, accept: :json}
      end
    end
  end
end
