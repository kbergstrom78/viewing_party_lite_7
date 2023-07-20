class MoviesController < ApplicationController
  def index
    @top_rated = if params['search'].present?
                    MovieFacade.keyword(params['search'])
                  else
                    MovieFacade.top_rated
                  end
  end

  def show
    @movie = MovieFacade.get_movie(params[:id])
    @cast = MovieFacade.top_ten_cast(params[:id])
    @reviews = MovieFacade.reviews(params[:id])
  end
end

