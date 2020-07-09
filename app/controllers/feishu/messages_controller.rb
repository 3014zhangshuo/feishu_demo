# frozen_string_literal: true

module Feishu
  class MessagesController < ApplicationController
    include Feishu::UrlVerification

    def receive
      Rails.logger.debug "request_parameters--------#{request.request_parameters['action']}"
      Rails.logger.debug "raw_post_to_hash--------#{raw_post_to_hash}"
      Rails.logger.debug "params--------#{params}"
    end

    private

    def raw_post_to_hash
      request.raw_post.split(/&/).inject({}) do |hash, setting|
        key, val = setting.split(/=/)
        hash[key.to_sym] = val
        hash
       end
    end
  end
end
