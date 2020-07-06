# frozen_string_literal: true

module Feishu
  module UrlVerification
    extend ActiveSupport::Concern

    included do
      before_action :return_challenge_as_json, if: -> { url_verification? }
    end

    private

    def return_challenge_as_json
      render json: { challenge: challenge }
    end

    def challenge
      params[:challenge]
    end

    def url_verification?
      params[:type] == 'url_verification'
    end
  end
end
