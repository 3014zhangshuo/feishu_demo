# frozen_string_literal: true

module Feishu
  module Token
    class ExternalTenantAccessToken < TenantAccessTokenBase
      attr_reader :app_access_token

      def initialize(app_id, app_secret)
        @app_access_token = ExternalAppAccessToken.new(Feishu.app_id, Feishu.app_secret)

        super(app_id, app_secret)
      end

      def payload
        {
          app_access_token: app_access_token.token,
          tenant_key: '' # TODO: add tenant_key
        }
      end

      def refresh_token
        data = @client.post('tenant_access_token/', payload: payload)
        data['app_access_token']
      end

      private

      def app_ticket
        # TODO: implement get and store app_ticket
      end
    end
  end
end
