# frozen_string_literal: ture

module Feishu
  class Auth < Base
    TENANT_ACCESS_TOKEN_URL = 'https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal/'

    def tenant_access_token
      @tenant_access_token ||= begin
        result =
          post(
            TENANT_ACCESS_TOKEN_URL,
            payload: {
              app_id: app_id,
              app_secret: app_secret
            }.to_json,
            headers: { content_type: :json, accept: :json }
          )

        JSON.parse(result)['tenant_access_token']
      end
    end
  end
end
