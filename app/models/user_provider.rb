# frozen_string_literal: true

class UserProvider < ApplicationRecord
  belongs_to :user

  serialize :extra, Hash

  class << self
    def find_or_create_with_info(info)
      find_with_info(info) || create_with_info(info)
    end

    private

    def find_with_info(info)
      where(openid: info['openid'], user_id: info['user_id']).first
    end

    def create_with_info(info)
      create(
        user_id: info['user_id'],
        openid: info['openid'],
        nick_name: info['nick_name'],
        phone: info['phone'],
        country: info['country'],
        extra: info
      )
    end
  end
end