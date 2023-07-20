# frozen_string_literal: true
class ViewingPartiesController < ApplicationController
  before_action :require_login, only: [:create]

  def new
    @user = User.find(params[:user_id])
    @movie = MovieFacade.get_movie(params[:movie_id])
    @users = User.all
  end

  def create
    @new_party = ViewingParty.new(party_params)
    @user = User.find(params[:host_id])
    if @new_party.save
      redirect_to user_path(@user.id)
      params[:user_ids].each do |user_id|
        UserViewingParty.create(user_id: user_id, viewing_party_id: @new_party.id)
      end
    else
      flash[:error] = 'Please fill out all fields'
      redirect_to new_user_movie_viewing_party_path(user_id: params[:user_id], movie_id: party_params[:movie_id])
    end
  end

  private

  def party_params
    params.permit(:duration, :party_date, :party_time, :movie_id, :host_id)
  end

  def require_login
    unless user_logged_in?
      flash[:error] = 'You must be logged in or registered to create a viewing party'
      redirect_to movie_path(params[:movie_id])
    end
  end
end
