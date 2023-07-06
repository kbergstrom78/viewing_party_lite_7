# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Discover Movies Page' do
  describe 'as a user when I visit the discover movies page' do
    before :each do
      @user1 = User.create!(name: 'Danny', email: 'callmeDan@yaho.com')
      @user2 = User.create!(name: 'Sandy', email: 'itsSandyifyounasty@hotmail.com')
      visit user_discover_index_path(@user1.id)
    end

    it 'I see a button to discover top rated movies', :vcr do

      expect(page).to have_content('Discover Movies Page')
      within '#top-rated' do
        expect(page).to have_button('Discover Top Rated Movies')

        click_button 'Discover Top Rated Movies'
      end
      expect(current_path).to eq(user_movie_index_path(@user1.id))
      expect(page).to have_content('Movies Results Page')
    end

    it 'I see a search field to search for movies by title, can click search button and see new movie', :vcr do

      within '#search-movies' do
        fill_in 'Enter Movie Title', with: 'The Godfather'
        click_button 'Search'
      end

      expect(current_path).to eq(user_movie_index_path(@user1.id))

      within '#movie-1' do
        expect(page).to have_link('The Godfather')
        expect(page).to have_content(8.7)
      end
    end
  end
end
