# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :user_provider_info

  after_commit :set_user_provider, on: :create

  has_many :providers, class_name: :UserProvider

  def self.new_with_session(params, session)
    super.tap do |user|
      Rails.logger.debug "new_with_session--------#{session[:user_provider_info]}"
      user.user_provider_info = session[:user_provider_info]
    end
  end

  def set_user_provider_with_session(session)
    Rails.logger.debug "set_user_provider_with_session--------#{session[:user_provider_info]}"
    user_provider_info = session[:user_provider_info]
    set_user_provider
  end

  private

  def set_user_provider
    return if user_provider_info.blank?

    user_provider_info['user_id'] = id
    UserProvider.find_or_create_with_info(user_provider_info)
  end
end