module Feishu
  class MessagesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def receive
      render json: { challenge: challenge }
    end

    private

    def challenge
      params[:challenge]
    end
  end
end
