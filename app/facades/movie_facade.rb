class MovieFacade

  def self.get_movie(id)
    movie_data = MovieService.get_movie(id)
    Movie.new(movie_data)
  end

  def self.top_rated
    MovieService.top_rated_movies[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def self.keyword(movie_query)
    MovieService.keyword_search(movie_query)[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
end