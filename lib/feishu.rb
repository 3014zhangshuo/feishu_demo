# frozen_string_literal: true

module Feishu
  APP_ID      = 'cli_9f86917eeb6c500d'
  APP_SECRET  = '0x3VWluv1JRm4yFY3VqXUdnBRLomU36W'
  EVENT_TOKEN = 'DR2zUfgHzwn1KraXbz6Escnxa3jmXzPm'
  AUTH_V3_BASE = 'https://open.feishu.cn/open-apis/auth/v3/'
  MESSAGE_BASE = 'https://open.feishu.cn/open-apis/message/v4/'
  AUTHEN_V1_BASE = 'https://open.feishu.cn/open-apis/authen/v1/'
  IMAGE_BASE = 'https://open.feishu.cn/open-apis/image/v4/'

  autoload :Api, 'feishu/api'
  autoload :Image, 'feishu/image'
  autoload :Oauth2, 'feishu/oauth2'
  autoload :Message, 'feishu/message'
  autoload :HttpClient, 'feishu/http_client'
  autoload :MessageSender, 'feishu/message_sender'
  autoload :MessageTemplate, 'feishu/message_template'

  module Token
    autoload :AccessToken, 'feishu/token/access_token'
    autoload :AppAccessTokenBase, 'feishu/token/app_access_token_base'
    autoload :ExternalAppAccessToken, 'feishu/token/external_app_access_token'
    autoload :InternalAppAccessToken, 'feishu/token/internal_app_access_token'
    autoload :TenantAccessTokenBase, 'feishu/token/tenant_access_token_base'
    autoload :ExternalTenantAccessToken, 'feishu/token/external_tenant_access_token'
    autoload :InternalTenantAccessToken, 'feishu/token/internal_tenant_access_token'
  end

  # TODO: need a loader
  class << self
    def event_token
      EVENT_TOKEN
    end

    def app_id
      APP_ID
    end

    def app_secret
      APP_SECRET
    end
  end

  class ResponseError < StandardError
    attr_reader :error_code
    def initialize(errcode, errmsg)
      @error_code = errcode
      super "#{errmsg}(#{error_code})"
    end
  end
end
