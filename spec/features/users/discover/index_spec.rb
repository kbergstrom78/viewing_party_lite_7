# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Discover Movies Page' do
  describe 'as a user when I visit the discover movies page' do
    before :each do
      @user1 = User.create!(name: 'Danny', email: 'callmeDan@yaho.com')
      @user2 = User.create!(name: 'Sandy', email: 'itsSandyifyounasty@hotmail.com')
    end

    it 'I see a button to discover top rated movies', :vcr do
      visit user_discover_index_path(@user1.id)

      expect(page).to have_content('Discover Movies Page')
      within '#top-rated' do
        expect(page).to have_button('Discover Top Rated Movies')

        click_button 'Discover Top Rated Movies'
      end
      expect(current_path).to eq(user_movie_index_path(@user1.id))
      expect(page).to have_content('Movies Results Page')
    end
  end
end
