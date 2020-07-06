# frozen_string_literal: true

module Feishu
  class EventsController < ApplicationController
    include Feishu::UrlVerification

    def create
      message.deliver
      Rails.logger.debug "--------#{message.message_id}"
      head :ok
    end

    private

    def message
      @message ||= begin
        if p2p_chat_create?
          Feishu::Message::Card.new(chat_id)
        else
          Feishu::Message::P2pChatCreate.new(chat_id)
        end
      end
    end

    def p2p_chat_create?
      event['type'] == 'p2p_chat_create'
    end

    def chat_id
      event['chat_id']
    end

    def event_type
      event['type']
    end

    def event
      params[:event]
    end
  end
end
