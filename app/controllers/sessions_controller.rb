class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash.now[:error] = 'Invalid Credentials. Please try again.'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_url, notice: "Logged out!"
  end
end