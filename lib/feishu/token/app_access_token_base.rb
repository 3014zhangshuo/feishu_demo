# frozen_string_literal: true

module Feishu
  module Token
    class AppAccessTokenBase
      attr_reader :app_id, :app_secret, :client

      def initialize(app_id, app_secret)
        @app_id = app_id
        @app_secret = app_secret
        @client = HttpClient.new('https://open.feishu.cn/open-apis/auth/v3/')
      end

      def headers
        { content_type: :json, accept: :json }
      end

      def payload
        {
          app_id: app_id,
          app_secret: app_secret
        }
      end

      def token
        read_token_from_store
      end

      private

      def read_token_from_store
        # TODO: store the token, refresh when token expired.
        refresh_token
      end
    end
  end
end
