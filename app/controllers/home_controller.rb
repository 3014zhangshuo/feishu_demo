# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    Rails.logger.debug "HomeController#index--------#{session[:user_provider_info]}"
  end
end
