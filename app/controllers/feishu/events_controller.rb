# frozen_string_literal: true

module Feishu
  class EventsController < ApplicationController
    include Feishu::UrlVerification

    before_action :check_token!

    def create
      handle_event
      render status: :ok
    end

    private

    def user
      @user ||= UserProvider.feishu..find_by_openid(openid)&.user
    end

    ::Feishu::MessageSender.new(
      ::Feishu::Message.new(
        to: { open_id: 'ou_dbda6b5c3078b57dc8707200eb1e67c7' },
        template: :fake_ticket
      )
    ).deliver

    def event_handler
      case event_type
      when 'p2p_chat_create'
        ::Feishu::MessageSender.new(
          ::Feishu::Message.new(
            to: { chat_id: chat_id },
            template: :p2p_chat_create
          )
        ).deliver
      when 'message'
        ::Feishu::MessageSender.new(
          ::Feishu::Message.new(
            to: { chat_id: chat_id },
            template: :bind_successfully,
            redirect_url: root_url(host: user.company.subdomain_addr)
          )
        ).deliver
      when 'app_ticket'
        app.change_extra(key: :app_ticket, value: app_ticket)
      when 'app_open'
        app.change_extra(key: :tenant_key, value: tenant_key)
      end
    end

    def app
      UserProviderApp.feishu.find_or_create_by(app_id: app_id)
    end

    def app_id
      event['app_id']
    end

    def app_ticket
      event['app_ticket']
    end

    def tenant_key
      event['tenant_key']
    end

    def openid
      event['open_id']
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
