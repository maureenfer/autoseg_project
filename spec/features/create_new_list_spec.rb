require 'rails_helper'

describe "the list's process", :type => :feature do

  before :each do
    FactoryGirl.create(:user)
    FactoryGirl.create(:list)
  end

  feature 'Create new List' , js: true do
    scenario 'User add a list and tasks' do
      visit 'users/sign_in'

      within("#new_user") do
        fill_in 'Email', with: 'email1@email.com'
        fill_in 'Password', with: 'pass123'
      end

      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content('Logout')

      visit lists_path
      expect(page).to have_content('New List')

      click_on 'New List'
      expect(page).to have_content('New List')

      within("#new_list") do
        fill_in 'list[name]', with: 'My list', match: :prefer_exact
        fill_in 'list[tasks_attributes][0][name]', with: 'My Task 1', match: :prefer_exact
        fill_in 'list[tasks_attributes][0][description]', with: 'My description 1', match: :prefer_exact
      end

      click_on 'Create'
      wait_for_ajax
      expect(page).to have_content('List was successfully created.')
    end
  end
end
