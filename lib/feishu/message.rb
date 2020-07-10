# frozen_string_literal: ture

module Feishu
  class Message < ::Feishu::Base
    COMMON_SEND_URL = 'https://open.feishu.cn/open-apis/message/v4/send/'
    BATCH_SEND_URL  = 'https://open.feishu.cn/open-apis/message/v4/batch_send/'

    attr_reader :auth
    attr_reader :template

    attr_accessor :result
    attr_accessor :message_id

    def initialize(**options)
      @auth = Auth.new
      @open_id = options[:openid] || options[:open_id]
      @open_ids = options[:openids] || options[:open_ids]
      @chat_id = options[:chat_id]
      @template = options[:template]
      @ticket = options[:ticket]
    end

    def header
      {
        Authorization: "Bearer #{auth.tenant_access_token}",
        content_type: :json,
        accept: :json
      }
    end

    def payload
      message_template.merge(payload_options).to_json
    end

    def deliver_successful?
      @result['code'].to_i.zero?
    rescue => e
      false
    end

    def deliver
      deliver_hander(COMMON_SEND_URL)
    end

    def batch_deliver
      deliver_hander(BATCH_SEND_URL)
    end

    private

    def payload_options
      return { open_ids: @open_ids } if batch_mode?

      { chat_id: @chat_id, open_id: @open_id }
    end

    def batch_mode?
      @openids.present?
    end

    def deliver_hander(url)
      result = post(url, payload: payload, headers: header)
      @result = JSON.parse(result)
      @message_id = @result['data']['message_id'] if deliver_successful?
    end

    def message_template
      MessageTemplate.fetch(template).call(ticket: @ticket)
    end
  end
end
