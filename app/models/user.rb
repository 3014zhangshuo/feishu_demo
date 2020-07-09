# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :provider_info

  after_commit :set_user_provider, on: :create

  has_many :providers, class_name: :UserProvider

  def self.new_with_session(params, session)
    super.tap do |user|
      Rails.logger.debug "new_with_session--------#{session[:user_provider_info]}"
      user.provider_info = session[:user_provider_info]
    end
  end

  def set_user_provider_with_session(session)
    Rails.logger.debug "set_user_provider_with_session--------#{session[:user_provider_info]}"
    self.provider_info = session[:user_provider_info]
    set_user_provider
  end

  private

  def set_user_provider
    return if provider_info.blank?
    Rails.logger.debug "string key openid--------#{provider_info['openid']}"
    Rails.logger.debug "symbol key openid--------#{provider_info[:openid]}"
    provider = providers.find_by_openid(provider_info['openid'])
    return if provider.present?

    providers.create_with_info(provider_info)
  end
end
