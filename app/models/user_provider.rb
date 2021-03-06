# frozen_string_literal: true

class UserProvider < ApplicationRecord
  belongs_to :user
  belongs_to :app, class_name: :UserProviderApp

  serialize :extra, Hash

  class << self
    alias feishu all

    def find_or_create_with_info(info)
      find_with_info(info) || create_with_info(info)
    end

    def find_with_info(info)
      where(openid: info['openid'], user_id: info['user_id']).first
    end

    def create_with_info(info)
      create!(
        app: UserProviderApp.feishu.first,
        openid: info['openid'],
        nick_name: info['nick_name'],
        extra: info
      )
    end
  end
end
