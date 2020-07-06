# frozen_string_literal: true

module Feishu
  autoload :Base, 'feishu/base'
  autoload :Auth, 'feishu/auth'
  autoload :Oauth, 'feishu/oauth'

  module Message
    autoload :Base, 'feishu/message/base'
    autoload :Card, 'feishu/message/card'
    autoload :P2pChatCreate, 'feishu/message/p2p_chat_create'
  end
end
