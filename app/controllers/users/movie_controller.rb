# frozen_string_literal: true

module Users
  class MovieController < ApplicationController
    def index
      @user = User.find(params[:user_id])
      @top_rated = if params['search'].present?
                      MovieFacade.keyword(params['search'])
                   else
                      MovieFacade.top_rated
                   end
    end

    def show
      @user = User.find(params[:user_id])
      @movie = MovieFacade.get_movie(params[:id])
    end
  end
end
