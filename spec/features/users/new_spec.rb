require 'rails_helper'

RSpec.describe 'register User', type: :feature do
  it "When click on regiter, were taken to a form" do

    name = "Sal's Calz(ones)"
    address = '123 Kindalikeapizza Dr.'
    city = "Denver"
    state = "CO"
    zip = 80204
    email = "email"
    password = "blah blah"

    expect(page).to have_content('Register')

    click_on 'Register'

    expect(current_path).to eq('/register')
    expect(page).to have_content('Name:')
    expect(page).to have_content('Address:')
    expect(page).to have_content('City:')
    expect(page).to have_content('State:')
    expect(page).to have_content('Zip:')
    expect(page).to have_content('Email:')
    expect(page).to have_content('Password:')

    fill_in :name, name
    fill_in :address, address
    fill_in :city, city
    fill_in :state, state
    fill_in :zip, zip
    fill_in :email, email
    fill_in :password, password

    
    click_on 'Register'

    expect(current_path).to eq('/profile')
  end
end