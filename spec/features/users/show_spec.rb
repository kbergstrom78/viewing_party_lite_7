# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  describe 'as a user when I visit the show page' do
    before :each do
      @user1 = User.create!(name: 'Danny', email: 'dannyzuko@grease.com')
      @user2 = User.create!(name: 'Sandy', email: 'sandy@grease.com')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit user_path(@user1.id)
    end

    it 'when I visit the user dashboard I see a header with user name' do
      expect(page).to have_link('Back to Landing Page')
      expect(page).to have_content('Viewing Party')
      expect(page).to have_content("#{@user1.name}'s Dashboard")
      expect(page).to_not have_content(@user2.name)
    end

    it 'when I visit the user dashboard I see a button to discover movies' do
      within '#discover-movies' do
        expect(page).to have_button('Discover Movies')
        expect(page).to_not have_content('My Viewing Parties')
      end
    end

    it 'when I visit the user dashboard I see a section for viewing parties' do
      within '#viewing-parties' do
        expect(page).to have_content('My Viewing Parties')
        expect(page).to_not have_content('Discover Movies')
      end
    end

    it 'when I visit the user dashboard and click the Discover Movies button' do
      within '#discover-movies' do
        click_button('Discover Movies')
      end

      expect(current_path).to eq(user_discover_index_path(@user1.id))
      expect(current_path).to_not eq(user_discover_index_path(@user2.id))
      expect(page).to have_link('Back to Landing Page')
      expect(page).to have_content('Viewing Party')
      expect(page).to have_content('Discover Movies')
    end
  end

  describe 'User dashboard with Viewing Parties' do
    before :each do
      @user1 = User.create!(name: 'Danny', email: 'dannyzuko@grease.com')
      @user2 = User.create!(name: 'Sandy', email: 'sandy@grease.com')
      @movie = Movie.new(title: 'The Godfather', id: 238, runtime: 175)
      @viewing_party = ViewingParty.create!(duration: 175, party_date: '2020-08-27', party_time: '19:00', movie_id: 238, host_id: @user1.id)
      @viewing_party.user_viewing_parties.create!(user_id: @user2.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit user_path(@user1.id)
    end

    it 'displays viewing parties that the user is hosting', :vcr do
      within '#viewing-parties' do
      save_and_open_page
        expect(page).to have_content('Godfather')
        expect(page).to have_content('Date')
        expect(page).to have_content('Time')
        expect(page).to have_content('Host')
        expect(page).to have_content('Invited')
        expect(page).to have_css('img', visible: true)
      end
    end
  end
end