require 'spec_helper'

feature 'User management' do
  scenario 'add a new user', js: true do
    sign_in create :admin

    visit root_path
    expect {
      click_link 'Users'
      click_link 'New User'
      fill_in 'Email', with: 'newuser@example.com'
      fill_in 'Password', with: 'secret1234'
      fill_in 'Password confirmation', with: 'secret1234'
      click_button 'Create User'
    }.to change(User, :count).by(1)
    expect(current_path).to eq users_path
    expect(page).to have_content 'New user created'
    within 'h1' do
      expect(page).to have_content 'Users'
    end
    expect(page).to have_content 'newuser@example.com'
  end
end
