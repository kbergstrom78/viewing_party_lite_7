require 'rails_helper'

RSpec.describe 'Viewing Party New Page' do
  describe 'as a user when I visit the new viewing party page' do
    before :each do
      @user1 = User.create!(name: 'Danny', email: 'hahaHA@yahoo.com')
      @movie = Movie.new(title: 'The Godfather', id: 238, runtime: 175)
      visit new_user_movie_viewing_party_path(@user1, @movie.id)
    end

    it 'displays the movie title, and a form for party', :vcr do
      expect(page).to have_content('The Godfather')

      within '#party-details' do
        expect(page).to have_content('Duration of Party')
        expect(page).to have_content('Date')
        expect(page).to have_content('Start Time')
      end
    end

    it 'has a form to add users to party', :vcr do
      within '#party-friends' do
        expect(page).to have_field('user_ids[]', type: 'checkbox') 
        expect(page).to have_button('commit', value: 'Create Party') 
      end
    end
  end
end