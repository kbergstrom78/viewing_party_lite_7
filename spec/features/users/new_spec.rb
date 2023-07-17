# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Registration' do
  describe 'as a user when I visit the registration page' do
    it 'displays a form to register' do
      visit '/register'

      within '#registration-form' do
        expect(page).to have_field('Name')
        expect(page).to have_field('Email')
        expect(page).to have_field('Password')
        expect(page).to have_field('Password Confirmation')
        expect(page).to have_content('Name')
        expect(page).to have_content('Email')
        expect(page).to have_content('Password')
        expect(page).to have_content('Password Confirmation')
        expect(page).to have_button('Save')
      end
    end

    it 'can fill out form and submit' do
      visit '/register'

      within '#registration-form' do
        fill_in 'Name', with: 'Bob'
        fill_in 'Email', with: 'gohomenow@hotmail.com'
        fill_in('Password', with: 'test', match: :prefer_exact)
        fill_in 'Password Confirmation', with: 'test'

        click_button 'Save'
      end

      @user = User.find_by(email: 'gohomenow@hotmail.com')
      expect(current_path).to eq(user_path(@user.id))
      expect(page).to have_content('Welcome, Bob!')
    end

    it 'will not create a user with incomplete information' do
      visit '/register'

      within '#registration-form' do
        fill_in 'Name', with: 'Bob'
        fill_in 'Email', with: 'gohomenow@hotmail.com'
        fill_in('Password', with: 'test', match: :prefer_exact)
        fill_in 'Password Confirmation', with: 'test'
        click_button 'Save'
      end

      @user = User.find_by(email: 'gohomenow@hotmail.com')
      expect(current_path).to eq(user_path(@user.id))

      visit '/register'

      within '#registration-form' do
        fill_in 'Name', with: 'Bob'
        fill_in 'Email', with: 'gohomenow@hotmail.com'
        fill_in('Password', with: 'test', match: :prefer_exact)
        fill_in 'Password Confirmation', with: 'test1'

        click_button 'Save'
      end

      expect(page).to have_content('Try again! All fields must be complete and email unique.')
    end
  end
end
