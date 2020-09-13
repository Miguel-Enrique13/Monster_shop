require 'rails_helper'

RSpec.describe 'User Registration', type: :feature do
  it "when I click on register, I can fill out the form and a USER is created" do

    name = 'Andy'
    address = '123 Street'
    city = 'Pawnee'
    state = 'Indiana'
    zip = '123456'
    email = 'andy@gmail.com'
    password = 'password'

    visit '/register'

    expect(current_path).to eq('/register')

    expect(page).to have_content('Name')
    expect(page).to have_content('Address')
    expect(page).to have_content('City')
    expect(page).to have_content('State')
    expect(page).to have_content('Zip')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on 'Register User'

    expect(current_path).to eq('/profile')

    expect(page).to have_content('You have been registered and are now logged in!')
  end

  it "User must have unique email" do
    User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password' )

    name = 'Andy'
    address = '123 Street'
    city = 'Pawnee'
    state = 'Indiana'
    zip = '123456'
    email = 'andy@gmail.com'
    password = 'password'

    visit '/register'

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on 'Register User'

    expect(page).to have_content('Email already taken')

  end

  it "Flash message when user registration improperly filled out" do
    name = 'Andy'
    address = '123 Street'
    city = 'Pawnee'
    state = 'Indiana'
    zip = '123456'
    email = 'andy@gmail.com'
    password = 'password'

    visit '/register'

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on 'Register User'

    expect(page).to have_content("Missing Information")
  end
end
