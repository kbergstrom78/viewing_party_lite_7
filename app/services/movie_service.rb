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
end