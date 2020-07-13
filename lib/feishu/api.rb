# frozen_string_literal: true

module Feishu
  module Api
    class << self
      def resend_app_ticket
        payload = {
          app_id: Feishu.app_id,
          app_secret: Feishu.app_secret
        }

        HttpClient.new(AUTH_V3_BASE)
                  .post('app_ticket/resend/', payload: payload)
      end
    end
  end
end
