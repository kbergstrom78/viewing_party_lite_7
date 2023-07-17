# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a registered user', type: :feature do
  before :each do
    @user1 = User.create!(name: 'Danny', email: 'danny123@grease.com', password: 'test1')
    @user2 = User.create!(name: 'Sandy', email: 'sandy246@grease.com', password: 'test2')
    @user3 = User.create!(name: 'Rizzo', email: 'rizzo678@grease.com', password: 'test3')
  end

  it 'has a landing page' do
    visit root_path
    expect(page).to have_content('Viewing Party')
    expect(page).to have_link('Create a New User')
    expect(page).to have_content('Existing Users')
    expect(page).to have_link(@user1.name)
    expect(page).to have_link(@user2.name)
    expect(page).to have_link(@user3.name)
  end
end
