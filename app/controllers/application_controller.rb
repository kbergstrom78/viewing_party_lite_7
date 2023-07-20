# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :user_logged_in?

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in?
    current_user.present?
  end
end
