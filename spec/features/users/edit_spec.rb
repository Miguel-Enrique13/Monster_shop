require 'rails_helper'

describe 'As a user' do
  before :each do
    @user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password' )

    visit '/login'
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_on 'log in'
  end

  it "I can edit my profile" do
    visit '/profile'

    name = "Elrich"
    address = "567 Sillicon Valley"
    city = "San Francisco"
    state = 'California'
    zip = '12345'
    email = "thisnewemail@email.com"

    expect(page).to have_content(@user.name)
    expect(page).to have_content(@user.address)
    expect(page).to have_content(@user.city)
    expect(page).to have_content(@user.zip)
    expect(page).to have_content(@user.email)

    click_on('Edit Information')

    expect(current_path).to eq('/profile/edit')

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip
    fill_in :email, with: email

    click_on 'Edit User'

    expect(current_path).to eq('/profile')

    expect(page).to have_content(name)
    expect(page).to have_content(address)
    expect(page).to have_content(city)
    expect(page).to have_content(state)
    expect(page).to have_content(zip)
    expect(page).to have_content(email)
    expect(page).to have_content("Your information has been updated")

  end
end
