# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = current_user
    @viewing_parties = @user.viewing_parties
    @parties_info = []
    @viewing_parties.each do |party|
      @parties_info << party.collect_display_data
    end
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    @new_user = User.new(user)
    if @new_user.save
      session[:user_id] = @new_user.id
      flash[:success] = "Welcome, #{user_params[:name]}!"
      redirect_to user_path(@new_user.id)
    else
      flash.notice = 'Try again! All fields must be complete and email unique.'
      redirect_to '/register'
    end
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
