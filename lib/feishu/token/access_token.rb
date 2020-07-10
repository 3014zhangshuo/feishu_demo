# frozen_string_literal: true

module Feishu
  module Token
    class AccessToken
      attr_reader :app_access_token, :code, :client, :openid, :grant_type

      def initialize(app_access_token, code, grant_type = 'authorization_code')
        @app_access_token = app_access_token
        @code = code
        @grant_type = grant_type
        @client = HttpClient.new('https://open.feishu.cn/open-apis/authen/v1/')
      end

      def payload
        {
          app_access_token: app_access_token,
          grant_type: grant_type,
          code: code
        }
      end

      def token
        read_token_from_store
      end

      def openid
        raw_info['data']['open_id']
      end

      private

      def read_token_from_store
        # TODO: store the token, refresh when token expired.
        refresh_token
      end

      def raw_info
        @raw_info ||= @client.post('access_token', payload: payload)
      end

      def refresh_token
        raw_info['data']['access_token']
      end
    end
  end
end
