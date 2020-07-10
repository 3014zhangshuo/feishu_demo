# frozen_string_literal: true

module Feishu
  module MessageTemplate
    extend self

    def fetch(template_name)
      template_result_map[template_name]
    end

    private

    def template_result_map
      {
        bind_successfully: ->(options) { bind_successfully },
        p2p_chat_create: ->(options) { p2p_chat_create },
        ticket: ->(options) { ticket(options[:ticket]) }
      }
    end

    def bind_successfully
      {
        msg_type: 'interactive',
        card: {
          config: {
            wide_screen_mode: true
          },
          header: header('欢迎使用Udesk智能客服！'),
          elements: [
            plain_text('Udesk智能客服，为您提供“沟通全渠道、管理全流程”的企业级SaaS服务。'),
            plain_text('您已经成功绑定账号，请点击“开始使用”进入Udesk智能客服。'),
            {
              tag: 'action',
              actions: [
                button('开始使用', qrcode_url)
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
          header: header('欢迎使用Udesk智能客服！'),
          elements: [
            plain_text('Udesk智能客服，为您提供“沟通全渠道、管理全流程”的企业级SaaS服务。'),
            plain_text('如您的团队已在使用Udesk智能客服系统，请先完成企业账号绑定。'),
            {
              tag: 'action',
              actions: [
                button('开始使用', qrcode_url)
              ]
            }
          ]
        }
      }
    end

    def ticket(ticket)
      {
        msg_type: 'interactive',
        card: {
          config: {
            wide_screen_mode: true
          },
          header: header('工单：ticket.feishu_card_message_title'),
          elements: [
            lark_md("**描述：**\n#{ticket.content}\n#{ticket.feishu_attachments_content}"),
            lark_md("**回复：**\n#{ticket.content}\n#{ticket_feishu_replies_content(ticket)}"),
            *ticket_feishu_replies_content(ticket),
            {
              tag: 'action',
              actions: [

              ]
            }
          ]
        }
      }
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

    def header(content)
      {
        title: {
          tag: 'plain_text',
          content: content
        }
      }
    end

    def plain_text(content)
      text('plain_text', content)
    end

    def lark_md(content)
      text('lark_md', content)
    end

    def text(tag, content)
      {
        tag: 'div',
        text: {
          tag: tag,
          content: content
        }
      }
    end

    def button(content, url)
      {
        tag: 'button',
        text: {
          tag: 'plain_text',
          content: content
        },
        url: url,
        type: 'primary'
      }
    end

    def select_static(placeholder_content, values)
      {
        tag: 'select_static',
        placeholder: {
          tag: plain_text,
          content: placeholder_content
        },
        options: values.map { |c, v| select_static_option(c, v) },
        value: {
          key: 'value'
        }
      }
    end

    def select_static_option(content, value)
      {
        text: {
          tag: 'plain_text',
          content: content
        },
        value: value
      }
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
