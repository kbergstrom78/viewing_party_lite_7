require 'rails_helper'

RSpec.describe 'Movie Results Page' do
  describe 'as a user when I visit the movie results page' do
    before :each do
      @user1 = User.create!(name: 'Danny', email: 'danny@email.com')
      @user2 = User.create!(name: 'Sandy', email: 'sandy@email.com')  
      visit user_movie_index_path(@user1.id)
    end

    it 'I see a list of 20 movies that match my search query', :vcr do
      within '#movie-1' do  
        expect(page).to have_content('The Godfather')
      end

      within '#movie-20' do
        expect(page).to have_content("Cinema Paradiso")
      end

      within '#movie-15' do
        expect(page).to have_content("Forrest Gump")
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
        expect(page).to have_link('Cinema Paradiso')
      end

      within '#movie-15' do
        expect(page).to have_link('Forrest Gump')
      end
    end
  end
end