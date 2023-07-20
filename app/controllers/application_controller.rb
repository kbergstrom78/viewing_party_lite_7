# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(params[:id])
  end
g
  def logged_in?
    !!current_user
  end


end
