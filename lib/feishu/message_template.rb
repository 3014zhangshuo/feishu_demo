# frozen_string_literal: true

module Feishu
  module MessageTemplate
    extend self

    def fetch(template_name)
      template_result_map[template_name].call
    end

    private

    def template_result_map
      {
        bind_successfully: -> { bind_successfully },
        p2p_chat_create: -> { p2p_chat_create },
        ticket: -> { ticket }
      }
    end

    def bind_successfully
      {
        msg_type: 'interactive',
        card: {
          config: {
            wide_screen_mode: true
          },
          header: {
            title: {
              tag: 'plain_text',
              content: '欢迎使用Udesk智能客服！'
            }
          },
          elements: [
            {
              tag: 'div',
              text: {
                tag: 'plain_text',
                content: 'Udesk智能客服，为您提供“沟通全渠道、管理全流程”的企业级SaaS服务。'
              }
            },
            {
              tag: 'div',
              text: {
                tag: 'plain_text',
                content: '您已经成功绑定账号，请点击“开始使用”进入Udesk智能客服。'
              }
            },
            {
              tag: 'action',
              actions: [
                {
                  tag: 'button',
                  text: {
                    tag: 'plain_text',
                    content: '开始使用'
                  },
                  url: qrcode_url,
                  type: 'primary'
                }
              ]
            }
          ]
        }
      }
    end

    def p2p_chat_create
      {
        msg_type: 'interactive',
        card: {
          config: {
            wide_screen_mode: true
          },
          header: {
            title: {
              tag: 'plain_text',
              content: '欢迎使用Udesk智能客服！'
            }
          },
          elements: [
            {
              tag: 'div',
              text: {
                tag: 'plain_text',
                content: 'Udesk智能客服，为您提供“沟通全渠道、管理全流程”的企业级SaaS服务。'
              }
            },
            {
              tag: 'div',
              text: {
                tag: 'plain_text',
                content: '如您的团队已在使用Udesk智能客服系统，请先完成企业账号绑定。'
              }
            },
            {
              tag: 'action',
              actions: [
                {
                  tag: 'button',
                  text: {
                    tag: 'plain_text',
                    content: '立即绑定'
                  },
                  url: qrcode_url,
                  type: 'primary'
                }
              ]
            }
          ]
        }
      }
    end

    def ticket
      {
        msg_type: 'interactive',
        card: {
          config: {
            wide_screen_mode: true
          },
          header: {
            title: {
              tag: 'plain_text',
              content: '工单：ticket.feishu_card_message_title'
            }
          },
          elements: [
            {
              tag: 'div',
              text: {
                tag: 'lark_md',
                content: "**描述：**\n#{ticket.content}\n#{ticket_attachments_content(ticket)}"
              }
            },
            {
              tag: 'div',
              text: {
                tag: 'lark_md',
                content: "**回复：**\n#{ticket.content}\n#{ticket_attachments_content(ticket)}"
              }
            },
            *ticket_feishu_replies_content(ticket),
            {
              tag: 'action',
              actions: [
                {
                  tag: 'select_static',
                  "placeholder": {
                    "tag": "plain_text",
                    "content": "Option-common mode"
                  },
                  "value": {
                    "key": "value"
                  },
                  "options": [
                    {
                      "text": {
                        "tag": "plain_text",
                        "content": "james"
                      },
                      "value": "james"
                    },
                    {
                      "text": {
                        "tag": "plain_text",
                        "content": "joy"
                      },
                      "value": "joy"
                    },
                    {
                      "text": {
                        "tag": "plain_text",
                        "content": "james_1"
                      },
                      "value": "james_1"
                    },
                    {
                      "text": {
                        "tag": "plain_text",
                        "content": "joy_1"
                      },
                      "value": "joy_1"
                    }
                  ]
                }
              ]
            }
          ]
        }
      }
    end

    def ticket_attachments_content(ticket)
      ticket.attachments.inject("") do |str, attachment|
        url = attachment.file.url
        str += "#{attachment.file_file_name} [预览](#{url}) [下载](#{url})\n"
      end
    end

    def ticket_feishu_replies_content(ticket)
      ticket.feishu_replies_content do |reply|
        {
          tag: 'note',
          elements: [
            {
              tag: 'lark_mk',
              content: reply.created_at_with_content
            },
            {
              tag: 'plain_text',
              content: reply.user.try(:nick_name)
            },
            {
              tag: 'img',
              img_key: 'f32**************************cf7',
              alt: {
                tag: 'plain_text',
                content: 'Note image size：16*16'
              }
            }
          ]
        }
      end
    end

    def qrcode_url
      query = {
        redirect_uri: 'http://39.107.65.149/feishu/oauth_callback',
        app_id: 'cli_9e7688822c74500c',
        state: 'feishu_cli_9e7688822c74500c'
      }.to_query

      "https://open.feishu.cn/open-apis/authen/v1/index?#{query}"
    end
  end
end
