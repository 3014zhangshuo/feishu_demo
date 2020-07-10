# frozen_string_literal: true

module Feishu
  module Token
    class InternalAppAccessToken < AppAccessTokenBase
      def refresh_token
        data = @client.get('app_access_token/internal/', payload: payload)
        data['app_access_token']
      end
    end
  end
end
