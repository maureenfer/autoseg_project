require 'rails_helper'

describe "the favorite process", :type => :feature do

  before :each do
    FactoryGirl.create(:user)
    FactoryGirl.create(:list)
  end

  feature 'Favorite a list' , js: true do
    scenario 'User add a list as favorite' do
      visit 'users/sign_in'

      within("#new_user") do
        fill_in 'Email', with: 'email1@email.com'
        fill_in 'Password', with: 'pass123'
      end

      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content('Logout')

      visit lists_path
      expect(page).to have_content('Lists')

      click_link 'add-fav'
      wait_for_ajax
      expect(page).to have_content('List was successfully favorited.')

      click_link 'add-fav'
      wait_for_ajax
      expect(page).to have_content('List has already been favorited.')
    end
  end
end
