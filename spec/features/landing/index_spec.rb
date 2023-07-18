require 'rails_helper'

RSpec.describe 'As a registered user', type: :feature do
  before :each do
    @user1 = User.create!(name: 'Danny', email: 'danny123@grease.com', password: 'password')
    @user2 = User.create!(name: 'Sandy', email: 'sandy246@grease.com', password: 'something')
    @user3 = User.create!(name: 'Rizzo', email: 'rizzo678@grease.com', password: 'anotherPassword')
  end

  it 'has a landing page' do
    visit login_path

    fill_in 'Email', with: @user1.email
    fill_in 'Password', with: @user1.password
    click_button 'Log In'

    visit root_path
    save_and_open_page
    expect(page).to have_content('Viewing Party')
    expect(page).to have_link('Log Out')
    expect(page).to have_content('Existing Users')
    expect(page).to have_content(@user1.email)
    expect(page).to have_content(@user2.email)
    expect(page).to have_content(@user3.email)
  end

  it 'can log in' do
    visit root_path

    click_link 'Log In'

    expect(current_path).to eq(login_path)

    fill_in 'Email', with: @user1.email
    fill_in 'Password', with: @user1.password
    click_button 'Log In'

    expect(page).to have_content('Welcome, Danny!')
    expect(current_path).to eq(user_path(@user1.id))
  end

  it 'can not log in with bad credentials' do
    visit root_path
    expect(page).to have_link('Log In')

    click_link 'Log In'
    expect(current_path).to eq(login_path)

    fill_in 'Email', with: @user2.email
    fill_in 'Password', with: 'wrong password'
    click_button 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to_not have_content('Welcome, Sandy!')
    expect(page).to have_content('Invalid Credentials. Please try again.')
  end

  it 'shows appropriate links when logged in' do
    user = User.create!(name: 'Bilbo', email: 'hobbit1@lotr.com', password: '123abc')
    visit login_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    visit root_path

    expect(page).not_to have_link('Log In')
    expect(page).not_to have_link('Create an Account')

    expect(page).to have_link('Log Out')

    click_link 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to have_link('Log In')
  end

  describe 'as a visitor, when I visit the landing page' do
    it 'does not show existing users' do
      visit root_path

      expect(page).not_to have_content('Existing Users')
    end
  end
end
