# frozen_string_literal: ture

module Feishu
  module Message
    class Base < ::Feishu::Base
      COMMON_SEND_URL = 'https://open.feishu.cn/open-apis/message/v4/send/'
      BATCH_SEND_URL  = 'https://open.feishu.cn/open-apis/message/v4/batch_send/'

      attr_reader :auth
      attr_reader :chat_id
      attr_accessor :result
      attr_accessor :message_id

      def initialize(chat_id)
        @auth = Auth.new
        @chat_id = chat_id
      end

      def header
        {
          Authorization: "Bearer #{auth.tenant_access_token}",
          content_type: :json,
          accept: :json
        }
      end

      def payload
        {}.merge(chat_id: chat_id).to_json
      end

      def deliver_successful?
        @result['code'].to_i.zero?
      rescue => e
        false
      end

      def deliver
        result = post(COMMON_SEND_URL, payload: payload, headers: header)
        @result = JSON.parse(result)
        @message_id = @result['data']['message_id'] if deliver_successful?
      end
    end
  end
end
