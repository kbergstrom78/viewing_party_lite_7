# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end

  def show; end

  def create
    @new_user = User.new(user_params)
      if @new_user.save
        session[:user_id] = @new_user.id
        redirect_to dashboard_path
      else
        flash.notice = "Try again! All fields must be complete and email unique."
        redirect_to '/register'
      end
  end


  private

  def user_params
    params.permit(:name, :email)
  end
end