# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  describe 'as a user when I visit the show page' do
    before :each do
      @user1 = User.create!(name: 'Danny', email: 'dannyzuko@grease.com')
      @user2 = User.create!(name: 'Sandy', email: 'sandy@grease.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit dashboard_path
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
        save_and_open_page
      end

      expect(current_path).to eq(user_discover_index_path(@user1.id))
      expect(current_path).to_not eq(user_discover_index_path(@user2.id))
      expect(page).to have_link('Back to Landing Page')
      expect(page).to have_content('Viewing Party')
      expect(page).to have_content('Discover Movies')
    end
  end
end
