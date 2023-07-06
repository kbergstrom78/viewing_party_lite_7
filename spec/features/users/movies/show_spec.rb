require 'rails_helper'

RSpec.describe 'Movie Show Page' do
  describe 'as a user when I visit the movie show page' do
    before :each do
      @user1 = User.create!(name: 'Danny', email: 'flyfish213@aol.com')
      visit "/users/#{@user1.id}/movie/238"
    end

    it 'I see the movie title, vote average, runtime, genre and summary', :vcr do
      within '#movie-details' do
        expect(page).to have_content('The Godfather')
        expect(page).to have_content('8.7')
        expect(page).to have_content('2h 55m')
        expect(page).to have_content('Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.')
        expect(page).to have_content('Crime')
        expect(page).to have_content('Drama')
      end
    end

    it 'I see the top ten cast members for the movie', :vcr do
      within '#movie-details' do
        expect(page).to have_content('Marlon Brando as Don Vito Corleone')
        expect(page).to have_content('John Marley as Jack Woltz')
        expect(page).to_not have_content('Richard Conte as Barzini')
      end
    end
  end
end