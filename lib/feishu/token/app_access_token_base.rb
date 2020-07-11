# frozen_string_literal: true

module Feishu
  module Token
    class AppAccessTokenBase
      attr_reader :app_id, :app_secret, :client

      def initialize(app_id, app_secret)
        @app_id = app_id
        @app_secret = app_secret
        @client = HttpClient.new(AUTH_V3_BASE)
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
