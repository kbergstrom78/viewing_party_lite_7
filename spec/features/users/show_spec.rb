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
    before(:each) do
      UserViewingParty.delete_all
      ViewingParty.delete_all
      User.delete_all
  
      json_response = File.read('spec/fixtures/movie.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/238?api_key=#{ENV['TMDB_API_KEY']}")
        .to_return(status: 200, body: json_response, headers: {})
  
      json_response_2 = File.read('spec/fixtures/movie2.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/278?api_key=#{ENV['TMDB_API_KEY']}")
        .to_return(status: 200, body: json_response_2, headers: {})
  
      @user1 = User.create!(name: 'Bob', email: 'bobbEE@aol.com')
      @user2 = User.create!(name: 'Sally', email: 'SeaShellZ@aol.com')
      @user3 = User.create!(name: 'Rizzo', email: 'RizzNizz@ghostmail.com')
      @movie_detail = Movie.new(JSON.parse(json_response, symbolize_names: true))
      @movie_detail_2 = Movie.new(JSON.parse(json_response_2, symbolize_names: true))
      @viewing_party_1 = ViewingParty.create!(duration: '180', host_id: @user1.id, movie_id: @movie_detail.id,
                                              party_date: Date.today, party_time: '17:00')
      @viewing_party_2 = ViewingParty.create!(duration: '200', host_id: @user2.id, movie_id: @movie_detail_2.id,
                                              party_date: Date.today - 1, party_time: '18:00')
      @viewing_party_user_1 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party_1.id)
      @viewing_party_user_2 = UserViewingParty.create!(user_id: @user1.id, viewing_party_id: @viewing_party_2.id)
      @viewing_party_user_3 = UserViewingParty.create!(user_id: @user2.id, viewing_party_id: @viewing_party_1.id)
     
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit user_path(@user1.id)
    end
    
    it 'displays viewing parties that the user is hosting', :vcr do
      within '#viewing-parties' do
       
        expect(page).to have_link('The Godfather')
        expect(page).to have_link('Shawshank Redemption')
      end
    end

    it 'displays viewing party details', :vcr do
      within '#viewing-parties' do

        expect(page).to have_content(@viewing_party_1.duration)
        expect(page).to have_content(@viewing_party_1.party_date.strftime('%B %d, %Y'))
        expect(page).to have_content('05:00PM')
        expect(page).to have_content('Bob')
      end
    end

    it 'displays attendees for each viewing party', :vcr do
      
      within "#attendees-#{@viewing_party_1.movie_id}" do
        expect(page).to have_content("#{@user1.name}")
        expect(page).to have_content("#{@user2.name}")
        expect(page).to_not have_content("#{@user3.name}")
      end
    end
  end
end
