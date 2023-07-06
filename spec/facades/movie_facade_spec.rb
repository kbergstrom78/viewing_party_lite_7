require 'rails_helper'  

RSpec.describe MovieFacade do
  describe 'creates movie facade' do
    it 'has movie facade with attributes', :vcr do
      movie = MovieFacade.get_movie(238)

      expect(movie).to be_a Movie
      expect(movie.title).to eq('The Godfather')
      expect(movie.vote_average).to eq(8.709)
      expect(movie.runtime).to eq('2h 55min')
      expect(movie.overview).to eq('Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.')
    end

    it 'creates a list of top rated movies', :vcr do
      top_rated = MovieFacade.top_rated
      expect(top_rated.first).to be_a Movie
    end

    it 'creates a list of movies by keyword search', :vcr do
      search = MovieFacade.keyword('The Godfather')
      expect(search.first).to be_a Movie
      expect(search.first.title).to eq('The Godfather')
      expect(search.first.vote_average).to eq(8.709)
    end
  end
end