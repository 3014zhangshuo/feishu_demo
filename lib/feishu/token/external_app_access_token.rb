# frozen_string_literal: true

module Feishu
  module Token
    class ExternalAppAccessToken < AppAccessTokenBase
      def payload
        super.merge(app_ticket: app_ticket)
      end

      def refresh_token
        data = @client.post('app_access_token/', payload: payload)
        data['app_access_token']
      end

      private

      def app_ticket
        UserProviderApp.feishu.find_by(app_id: app_id).app_ticket
      end
    end
  end
end
