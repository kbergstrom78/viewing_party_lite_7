# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie do
  describe 'creates movie object' do
    it 'has movie attributes' do
      movie = Movie.new({ title: 'The Godfather', vote_average: 8.709, runtime: 175,
                          overview: 'Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.' })

      expect(movie).to be_a Movie
      expect(movie.title).to be_a String
      expect(movie.title).to eq('The Godfather')
      expect(movie.vote_average).to be_a Float
      expect(movie.vote_average).to eq(8.709)
      expect(movie.runtime).to be_a String
      expect(movie.runtime).to eq('2h 55min')
      expect(movie.overview).to be_a String
      expect(movie.overview).to eq('Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.')
    end

    it 'has method to format runtime' do
      movie = Movie.new({ title: 'The Godfather', vote_average: 8.709, runtime: 175,
                          overview: 'Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.' })

      expect(movie.format_runtime(175)).to eq('2h 55min')
    end
  end
end
