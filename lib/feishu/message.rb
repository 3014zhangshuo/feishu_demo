# frozen_string_literal: ture

module Feishu
  class Message < ::Feishu::Base
    COMMON_SEND_URL = 'https://open.feishu.cn/open-apis/message/v4/send/'
    BATCH_SEND_URL  = 'https://open.feishu.cn/open-apis/message/v4/batch_send/'

    attr_reader :auth
    attr_reader :chat_id
    attr_reader :openid
    attr_reader :template

    attr_accessor :result
    attr_accessor :message_id

    def initialize(**options)
      raise(ArgumentError, 'Must pass chat_id or openid') if [options[:chat_id], options[:openid]].all?(&:blank?)
      @auth = Auth.new
      @openid = options[:openid]
      @chat_id = options[:chat_id]
      @template = options[:template]
    end

    def header
      {
        Authorization: "Bearer #{auth.tenant_access_token}",
        content_type: :json,
        accept: :json
      }
    end

    def payload
      message_template.merge(chat_id: chat_id, open_id: openid).to_json
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

    private

    def message_template
      MessageTemplate.fetch(template)
    end
  end
end
