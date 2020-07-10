# frozen_string_literal: true

# https://open.feishu.cn/document/ukTMukTMukTM/uADN14CM0UjLwQTN
# https://open.feishu.cn/document/ukTMukTMukTM/uETOwYjLxkDM24SM5AjN
module Feishu
  class Oauth2 < Base
    attr_reader :code, :app_access_token, :access_token, :user_access_token,
                :client

    def initialize(code)
      @code = code
      @app_access_token = Token::InternalAppAccessToken.new(app_id, app_secret)
      @access_token = Token::AccessToken.new(app_access_token.token, code)
      @user_access_token = access_token.token
      @client = HttpClient.new('https://open.feishu.cn/open-apis/authen/v1/')
    end

    def info
      {
        channel: 'feishu',
        openid: access_token.openid,
        nick_name: user_info['data']['name'],
        phone: user_info['data']['mobile'],
        email: user_info['data']['email'],
        user_id: user_info['data']['user_id'],
        avatar_url: user_info['data']['avatar_url']
      }
    end

    private

    def user_info
      @user_info ||= client.get('user_info', payload: payload, headers: headers)
    end

    def headers
      {
        Authorization: "Bearer #{user_access_token}",
        content_type: :json,
        accept: :json
      }
    end

    def payload
      { user_access_token: user_access_token }
    end
  end
end
