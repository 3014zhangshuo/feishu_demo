# frozen_string_literal: true

module Feishu
  module Token
    class InternalTenantAccessToken < TenantAccessTokenBase
      def refresh_token
        data = @client.get('tenant_access_token/internal/', payload: payload)
        data['tenant_access_token']
      end
    end
  end
end
