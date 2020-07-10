# frozen_string_literal: true

module Feishu
  class MessagesController < ApplicationController
    include Feishu::UrlVerification

    def receive
      Rails.logger.debug "action_info--------#{action_info}"
    end

    private

    def action_info
      params[:message][:action]
    end
  end
end
