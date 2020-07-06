# frozen_string_literal: ture

module Feishu
  module Message
    class Card < Base
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
                content: '卡片消息标题'
              }
            },
            element: [
              {
                tag: 'div',
                text: {
                  tag: 'plain_text',
                  content: 'Element 1'
                }
              },
              {
                tag: 'action',
                actions: [
                  {
                    tag: 'button',
                    text: {
                      tag: 'plain_text',
                      content: 'Read'
                    },
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
