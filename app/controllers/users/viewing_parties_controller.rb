# frozen_string_literal: true

module Users
  class ViewingPartiesController < ApplicationController

    def new
      @user = User.find(params[:user_id])
      @movie = MovieFacade.get_movie(params[:movie_id])
      @users = User.all
    end

    def create;
    end
  end
end
