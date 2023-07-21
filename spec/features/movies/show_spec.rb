# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movie Show Page' do
  describe 'as a user when I visit the movie show page' do
    before :each do
      @user1 = User.create!(name: 'Danny', email: 'flyfish213@aol.com', password: 'test1')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit movie_path(238)
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

    it 'displays total count of reviews', :vcr do
      within '#movie-reviews' do
        expect(page).to have_content(5)
      end
    end

    it 'displays each review with author and content', :vcr do
      within '#movie-reviews' do
        expect(page).to have_content('futuretv')
        expect(page).to have_content('The Godfather is a film considered by most to be one of the greatest ever made.')
        expect(page).to have_content('Suresh Chidurala')
        expect(page).to have_content('Great Movie **Ever**')
      end
    end

    it 'has a button to create a viewing party', :vcr do
      within '#create-party' do
        expect(page).to have_link('Create Viewing Party')
        click_link 'Create Viewing Party'
      end
      expect(current_path).to eq(new_movie_viewing_party_path(238))
    end

    it 'has a button to return to the Discover Page', :vcr do
      within '#discover' do
        expect(page).to have_button('Back to Discover')
        click_button 'Back to Discover'
      end
      expect(current_path).to eq(discover_index_path)
    end
  end
end
