# frozen_string_literal: ture

module Feishu
  class MessageSender
    attr_reader :message, :tenant_access_token, :client

    def initialize(message)
      @message = message
      @tenant_access_token = Token::InternalTenantAccessToken.new(Feishu.app_id, Feishu.app_secret)
      @client = HttpClient.new('https://open.feishu.cn/open-apis/message/v4/')
    end

    def batch_deliver
      client.post('batch_send/', payload: payload, headers: headers)
    end

    def deliver
      client.post('send/', payload: payload, headers: headers)
    end

    private

    def headers
      { Authorization: "Bearer #{tenant_access_token.token}" }
    end

    def payload
      message.to_payload
    end
  end
end
