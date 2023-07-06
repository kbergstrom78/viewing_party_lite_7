# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Registration' do
  describe 'as a user when I visit the registration page' do
    it 'display a form to register' do
      visit '/register'

      within '#registration-form' do
        expect(page).to have_field('Name')
        expect(page).to have_field('Email')
        expect(page).to have_content('Name')
        expect(page).to have_content('Email')
        expect(page).to have_button('Save')
      end
    end

    it 'can fill out form and submit' do
      visit '/register'

      within '#registration-form' do
        fill_in 'Name', with: 'Bob'
        fill_in 'Email', with: 'gohomenow@hotmail.com'

        click_button 'Save'
      end

      expect(current_path).to eq(dashboard_path)
    end

    it 'will not create a user with incomplete information' do
      visit '/register'

      within '#registration-form' do
        fill_in 'Name', with: 'Bob'
        fill_in 'Email', with: 'gohomenow@hotmail.com'

        click_button 'Save'
      end
      expect(current_path).to eq(dashboard_path)

      visit '/register'

      within '#registration-form' do
        fill_in 'Name', with: 'Bob'
        fill_in 'Email', with: 'gohomenow@hotmail.com'

        click_button 'Save'
      end
      
      expect(page).to have_content('Try again! All fields must be complete and email unique.')
    end
  end
end
