require 'rails_helper'

describe 'As a user' do
  before :each do
    @user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password' )

    visit '/login'
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_on 'log in'
  end

  it "I can change my password and log in with it" do
      visit '/profile'

      expect(page).to have_link('Edit Password')

      click_on 'Edit Password'

      expect(page).to have_content("New Password")
      expect(page).to have_content("Confirm Password")

      fill_in :password, with: "New_password"
      fill_in :password_confirmation, with: "New_password"

      click_on("Update Password")

      expect(current_path).to eq('/profile')
      expect(page).to have_content('Password has been updated')

      click_on 'Log out'
      visit '/login'
      fill_in :email, with: @user.email
      fill_in :password, with: 'New_password'
      click_on 'log in'

      expect(page).to have_content('You have been logged in')
  end
end
