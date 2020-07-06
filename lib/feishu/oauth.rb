# frozen_string_literal: true

# https://open.feishu.cn/document/ukTMukTMukTM/uADN14CM0UjLwQTN
# https://open.feishu.cn/document/ukTMukTMukTM/uETOwYjLxkDM24SM5AjN
# https://github.com/rest-client/rest-client/issues/397
module Feishu
  class Oauth < Base
    USER_INFO_URL = "https://open.feishu.cn/open-apis/authen/v1/user_info"
    ACCESS_TOKEN_URL = "https://open.feishu.cn/open-apis/authen/v1/access_token"
    APP_ACCESS_TOKEN_URL = "https://open.feishu.cn/open-apis/auth/v3/app_access_token/internal/"

    attr_reader :code

    def initialize(code)
      @code = code
    end

    def info
      JSON.parse(user_info).merge(openid: openid)
    end

    def openid
      raw_access_token["open_id"]
    end

    def user_access_token
      raw_access_token["access_token"]
    end

    def app_access_token
      raw_app_access_token["app_access_token"]
    end

    def raw_app_access_token
      @raw_app_access_token ||= begin
        result =
          post(
            APP_ACCESS_TOKEN_URL,
            payload: {
              app_id: app_id,
              app_secret: app_secret
            }.to_json,
            headers: { content_type: :json, accept: :json }
          )

        JSON.parse(result)
      end
    end

    def raw_access_token
      @raw_access_token ||= begin
        result =
          post(
            ACCESS_TOKEN_URL,
            payload: {
              app_access_token: app_access_token,
              grant_type: "authorization_code",
              code: code
            }.to_json,
            headers: { content_type: :json, accept: :json }
          )

        JSON.parse(result)['data']
      end
    end

    def user_info
      @user_info ||= begin
        get(
          USER_INFO_URL,
          payload: {
            user_access_token: user_access_token
          },
          headers: {
            Authorization: "Bearer #{user_access_token}",
            content_type: :json,
            accept: :json
          }
        )
      end
    end
  end
end
