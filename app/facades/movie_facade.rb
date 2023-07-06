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

  def self.top_ten_cast(id)
    cast_chars = []
    MovieService.get_cast(id)[:cast][0..9].map do |cast_data|
      cast_chars << "#{cast_data[:name]} as #{cast_data[:character]}"
    end
    cast_chars
  end

  def self.reviews(id)
    review_data = []
    MovieService.get_reviews(id)[:results].map do |review|
      review_data << "#{review[:author]}'s review: #{review[:content]}"
    end
    review_data
  end
end