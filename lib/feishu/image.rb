# frozen_string_literal: true

module Feishu
  class Image
    attr_reader :client, :tenant_access_token

    def initialize
      @client = HttpClient.new(IMAGE_BASE)
      @tenant_access_token = Token::InternalTenantAccessToken.new(Feishu.app_id, Feishu.app_secret)
    end

    def put(image, image_type = 'avatar')
      payload = { image: File.new(image, 'rb'), image_type: image_type }
      options = { overwrite_headers: true, payload_as_original: true }

      client.post('put/', payload: payload, headers: headers, **options)
    end

    # TODO: it's not implement
    def get(image_key)
      client.get("get?image_key=#{image_key}", headers: headers)
    end

    private

    def headers
      { Authorization: "Bearer #{tenant_access_token.token}" }
    end
  end
end
