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
  end
end