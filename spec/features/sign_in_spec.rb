require 'rails_helper'

describe "the signin process", :type => :feature do
  before :each do
    FactoryGirl.create(:user)
  end

  feature 'Visitor signs up' do
    scenario "signs me in" do
      visit 'users/sign_in'

      within("#new_user") do
        fill_in 'Email', :with => 'email1@email.com'
        fill_in 'Password', :with => 'pass123'
      end

      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content('Logout')
    end

    scenario 'with invalid email' do
      visit 'users/sign_in'

      within("#new_user") do
        fill_in 'Email', :with => 'email@'
        fill_in 'Password', :with => 'pass123'
      end

      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end

    scenario 'with blank password' do
      visit 'users/sign_in'

      within("#new_user") do
        fill_in 'Email', :with => 'email@email.com'
        fill_in 'Password', :with => ''
      end

      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end
  end
end