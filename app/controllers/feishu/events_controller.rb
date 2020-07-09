# frozen_string_literal: true

module Feishu
  class EventsController < ApplicationController
    include Feishu::UrlVerification

    before_action :check_token!

    def create
      message.deliver
      Rails.logger.debug "--------#{message.message_id}"
      render status: :ok
    end

    private

    def message
      @message ||= begin
        if p2p_chat_create?
          ::Feishu::Message.new(chat_id: chat_id, template: :p2p_chat_create)
        else
          ::Feishu::Message.new(chat_id: chat_id, template: :bind_successfully)
        end
      end
    end

    def p2p_chat_create?
      event['type'] == 'p2p_chat_create'
    end

    def chat_id
      event['chat_id'] || event['open_chat_id']
    end

    def event_type
      event['type']
    end

    def event
      params[:event]
    end

    def check_token!
      return if params[:token] == ::Feishu.event_token

      render status: :forbidden
    end
  end
end
