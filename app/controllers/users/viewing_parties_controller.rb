module Users
  class ViewingPartiesController < ApplicationController
    def new
      @user = User.find(params[:user_id])
      @movie = MovieFacade.get_movie(params[:movie_id])
      @users = User.all
    end

    def create
      @new_party = ViewingParty.new(party_params)
      if @new_party.save
        redirect_to dashboard_path(current_user)
      else
        render :new
      end
    end

    private

    def party_params
      params.permit(:movie_id, :duration, :party_date, :party_time, user_ids: [])
    end
  end
end