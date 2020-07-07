# frozen_string_literal: true

class UserProvider < ApplicationRecord
  belongs_to :user

  enum channel: { qywx: 0, feishu: 1 }

  serialize :extra, Hash

  def self.create_with_info(info)
    create(
      channel: info[:channel],
      openid: info[:openid],
      nick_name: info[:nick_name],
      phone: info[:phone],
      country: info[:country],
      extra: info
    )
  end
end
