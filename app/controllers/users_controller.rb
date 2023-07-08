# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = current_user
    @hosted_parties = ViewingParty.where(host_id: @user.id)
    # @invited_parties = @user.viewing_parties
  end

  def create
    @new_user = User.create(user_params)
    if @new_user.save
      session[:user_id] = @new_user.id
      redirect_to user_path(@new_user.id)
    else
      flash.notice = 'Try again! All fields must be complete and email unique.'
      redirect_to '/register'
    end
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end
