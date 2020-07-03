module Feishu
  class MessagesController < ApplicationController
    def receive
      render json: { challenge: challenge }
    end

    private

    def feishu_oauth2_url
      "https://open.feishu.cn/open-apis/authen/v1/index?redirect_uri=http://39.107.65.149/feishu/oauth_callback&app_id=cli_9e7688822c74500c"
    end

    def challenge
      params[:challenge]
    end
  end
end
