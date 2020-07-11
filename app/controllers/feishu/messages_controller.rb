# frozen_string_literal: true

module Feishu
  class MessagesController < ApplicationController
    include Feishu::UrlVerification

    def receive
      Rails.logger.debug "action_info--------#{action_info}"
      parse_option
    end

    private

    def parse_option
      case option
      when /\Aassignee_id_(\d+)\z/
        Rails.logger.debug "ticket_id--------#{ticket_id}"
        Rails.logger.debug "assignee_id------#{$2}"
      when /\Astatus_id_(\d+)\z/
        Rails.logger.debug "ticket_id--------#{ticket_id}"
        Rails.logger.debug "status_id--------#{$2}"
      end
    end

    def action_info
      params[:message][:action]
    end

    def option
      action_info['option']
    end

    def ticket
      @ticket ||= user.company.tickets.find(ticket_id)
    end

    def ticket_id
      action_info.dig('value', 'ticket_id')
    end

    def user
      @user ||= UserProvider.feishu.find_by_openid(openid)&.user
    end

    def openid
      paras[:open_id]
    end
  end
end
