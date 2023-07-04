class PagesController < ApplicationController
  def landing
    @users = User.all
  end
end