# frozen_string_literal: true

class MovieService
  def self.get_movie(id)
    JSON.parse(conn.get("movie/#{id}").body, symbolize_names: true)
  end

  def self.top_rated_movies
    JSON.parse(conn.get('movie/top_rated').body, symbolize_names: true)
  end

  def self.keyword_search(movie_query)
    JSON.parse(conn.get("search/movie?query=#{movie_query}").body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org/3/') do |f|
      f.params['api_key'] = ENV['TMDB_API_KEY']
    end
  end

  def self.get_cast(id)
    JSON.parse(conn.get("movie/#{id}/credits").body, symbolize_names: true)
  end

  def self.get_reviews(id)
    JSON.parse(conn.get("movie/#{id}/reviews").body, symbolize_names: true)
  end

  def self.get_images(id)
    JSON.parse(conn.get("movie/#{id}/images").body, symbolize_names: true)
  end
end
