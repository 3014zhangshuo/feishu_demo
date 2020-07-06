# frozen_string_literal: true

module Feishu
  module Message
    class P2pChatCreate < Base
      def payload
        {
          msg_type: 'interactive',
          card: {
            config: {
              wide_screen_mode: true
            },
            header: {
              title: {
                tag: 'plain_text',
                content: '欢迎使用 Udesk 👏'
              }
            },
            elements: [
              {
                tag: 'div',
                text: {
                  tag: 'plain_text',
                  content: '请配置应用吧'
                }
              },
              {
                tag: 'action',
                actions: [
                  {
                    tag: 'button',
                    text: {
                      tag: 'plain_text',
                      content: '配置应用'
                    },
                    url: 'https://open.feishu.cn/open-apis/authen/v1/index?redirect_uri=http://39.107.65.149/feishu/oauth_callback&app_id=cli_9e7688822c74500c',
                    type: 'default'
                  }
                ]
              }
            ]
          }
        }.merge(chat_id: chat_id).to_json
      end
    end
  end
end
