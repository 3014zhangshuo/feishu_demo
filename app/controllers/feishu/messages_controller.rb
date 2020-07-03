module Feishu
  class MessagesController < ApplicationController
    def receive
      render json: { challenge: challenge }
    end

    private

    def challenge
      params[:challenge]
    end
  end
end
