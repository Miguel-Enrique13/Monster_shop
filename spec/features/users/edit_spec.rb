require 'rails_helper'

describe 'As a user' do
  before :each do
    @bob = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password' )
    @eduardo = User.create!(name: 'Eduardo', address: "Calle 13", city: 'Edmonton', state: 'Alberta', zip: '459820', email: 'eduardo@gmail.com', password: 'password', password_confirmation: 'password' )

    visit '/login'
    fill_in :email, with: @bob.email
    fill_in :password, with: @bob.password
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

    expect(page).to have_content(@bob.name)
    expect(page).to have_content(@bob.address)
    expect(page).to have_content(@bob.city)
    expect(page).to have_content(@bob.zip)
    expect(page).to have_content(@bob.email)

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

  it "I can't change email to one already used" do
    email = @eduardo.email

    visit '/profile'
    click_on('Edit Information')

    fill_in :email, with: email

    click_on 'Edit User'

    expect(current_path).to eq('/profile/edit')
    expect(page).to have_content('Email has already been taken')
  end
end
