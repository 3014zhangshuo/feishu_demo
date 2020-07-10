# frozen_string_literal: ture

module Feishu
  class Message
    def initialize(**options)
      @to = options.delete(:to)
      @template = options.delete(:template)
      @message_hash = MessageTemplate.fetch(@template).call(options)
    end

    def to_payload
      message_hash
    end
  end
end
