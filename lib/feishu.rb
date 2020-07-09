# frozen_string_literal: true

module Feishu
  autoload :Base, 'feishu/base'
  autoload :Auth, 'feishu/auth'
  autoload :Oauth, 'feishu/oauth'
  autoload :Message, 'feishu/message'
  autoload :MessageTemplate, 'feishu/message_template'

  EVENT_TOKEN = 'Q7Fcikv1a8qb1FeyMvOoTdwlLYorryKQ'

  def self.event_token
    EVENT_TOKEN
  end
end
