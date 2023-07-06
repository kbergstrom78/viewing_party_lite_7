require 'rails_helper'

RSpec.describe MovieService do
  describe 'class methods' do
    it 'can create an connection and consume api', :vcr do
      movies = MovieService.get_movie(238)

      expect(movies).to be_a Hash
      expect(movies).to have_key :original_title
      expect(movies[:original_title]).to be_a String
      expect(movies[:original_title]).to eq('The Godfather')

    end

    it 'can get top rated movies', :vcr do
      top_rated = MovieService.top_rated_movies

      expect(top_rated).to be_a Hash
      expect(top_rated).to have_key :results
      expect(top_rated[:results]).to be_an Array
      expect(top_rated[:results].first[:title]).to be_a String
      expect(top_rated[:results].first[:title]).to eq('The Godfather')
    end

    it 'can get movies by keyword search', :vcr do
      search = MovieService.keyword_search('The Godfather')

      expect(search).to be_a Hash
      expect(search).to have_key :results
      expect(search[:results]).to be_an Array
      expect(search[:results].first[:title]).to be_a String
      expect(search[:results].first[:title]).to eq('The Godfather')
    end
  end
end