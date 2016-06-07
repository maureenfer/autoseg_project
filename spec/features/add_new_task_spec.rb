require 'rails_helper'

describe "the task's process", :type => :feature do

  before :each do
    FactoryGirl.create(:user)
    FactoryGirl.create(:list)
  end

  feature 'Create new task' , js: true do
    scenario 'User create multiple tasks' do
      visit 'users/sign_in'

      within("#new_user") do
        fill_in 'Email', with: 'email1@email.com'
        fill_in 'Password', with: 'pass123'
      end

      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
      expect(page).to have_content('Logout')

      visit tasks_path
      expect(page).to have_content('Tasks')

      click_on 'New Task'
      expect(page).to have_content('New Task')

      within("#new_task") do
        select('My List 1', from: 'task[list_id][]', visible: false)
        fill_in 'task[name][]', with: 'My Task 1', match: :prefer_exact
        fill_in 'task[description][]', with: 'My description 1', match: :prefer_exact
      end

      click_on 'addButton'

      expect(page).to have_css('.append')
      within(".append") do
        select('My List 1', from: 'task[list_id][]', match: :first)
        fill_in 'task[name][]', with: 'My Task 2', match: :prefer_exact
        fill_in 'task[description][]', with: 'My description 2', match: :prefer_exact
      end

      click_on 'Create'
      wait_for_ajax
      expect(page).to have_content('Task was successfully created.')
    end
  end
end
