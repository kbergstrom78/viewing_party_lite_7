# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movie Results Page' do
  describe 'as a user when I visit the movie results page' do
    before :each do
      @user1 = User.create!(name: 'Danny', email: 'danny@email.com', password: 'test1')
      @user2 = User.create!(name: 'Sandy', email: 'sandy@email.com', password: 'test2')
      visit user_movie_index_path(@user1.id)
    end

    it 'I see a list of 20 movies that match my search query', :vcr do
      within '#movie-1' do
        expect(page).to have_content('The Godfather')
      end

      within '#movie-20' do
        expect(page).to have_content('Gabriel\'s Inferno')
      end

      within '#movie-15' do
        expect(page).to have_content('Lord of the Rings: The Return of the King')
      end
    end

    it 'I see each movie has a vote average', :vcr do
      within '#movie-1' do
        expect(page).to have_content(8.7)
      end

      within '#movie-20' do
        expect(page).to have_content(8.5)
      end

      within '#movie-15' do
        expect(page).to have_content(8.5)
      end
    end

    it 'I see each movie has a title that is a link to the movie show page', :vcr do
      within '#movie-1' do
        expect(page).to have_link('The Godfather')
      end

      within '#movie-20' do
        expect(page).to have_link('Gabriel\'s Inferno')
      end

      within '#movie-15' do
        expect(page).to have_link('Lord of the Rings: The Return of the King')
      end
    end
  end
end
