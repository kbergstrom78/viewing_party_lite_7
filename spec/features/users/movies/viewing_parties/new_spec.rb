# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Viewing Party New Page' do
  describe 'as a user when I visit the new viewing party page' do
    before :each do
      @user1 = User.create!(name: 'Danny', email: 'hahaHA@yahoo.com')
      @user2 = User.create!(name: 'Sandy', email: 'sadnyBottomZ@aol.com')
      @user3 = User.create!(name: 'Rizzo', email: 'RizzNIzz@hotmail.com')
      @movie = Movie.new(title: 'The Godfather', id: 238, runtime: 175)
      visit new_user_movie_viewing_party_path(@user1, @movie.id)
    end

    it 'displays the movie title, and a form for party', :vcr do
      expect(page).to have_content(@movie.title)

      within '#party-details' do
        expect(page).to have_content('Duration of Party')
        expect(page).to have_content('Date')
        expect(page).to have_content('Start Time')
        expect(page).to have_field('user_ids[]', type: 'checkbox')
        expect(page).to have_button('Create Party')
      end
    end

    it 'can fill out form and create party', :vcr do
      user_locator = "user_ids_#{@user2.id}"

      within '#party-details' do
        fill_in :duration, with: 175
        fill_in :party_date, with: '2021-07-04'
        fill_in :party_time, with: Time.now

        expect(page).to have_field(user_locator, type: 'checkbox')
        check(user_locator)
        click_button 'Create Party'
      end

      expect(current_path).to eq(user_path(@user1.id))
    end
  end
end
