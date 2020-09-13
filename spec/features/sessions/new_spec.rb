require 'rails_helper'

RSpec.describe "Logging In" do
  it "General user can log in with valid credentials" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password' )

    visit items_path

    click_on 'login'

    expect(current_path).to eq(login_index_path)

    expect(page).to have_content("Email")
    expect(page).to have_content("Password")

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'

    expect(current_path).to eq('/profile')
    expect(page).to have_content("You have been logged in")
  end

  it "Merchant user can log in with valid credentials" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 1 )

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'

    expect(current_path).to eq('/merchant/dashboard')
    expect(page).to have_content("You have been logged in")

  end

  it "Admin user can log in with valid credentials" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 2 )

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'

    expect(current_path).to eq('/admin/dashboard')
    expect(page).to have_content("You have been logged in")

  end

  it "Get error when wrong password used" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 2 )
    wrong_password = "wrong_password"

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: wrong_password

    click_on 'log in'

    expect(current_path).to eq('/login')
    expect(page).to have_content("Incorrect Password or Email")

  end

  it "Get error when wrong password used" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 2 )
    wrong_email = "wrongemail@email.com"

    visit items_path

    click_on 'login'

    fill_in :email, with: wrong_email
    fill_in :password, with: user.password

    click_on 'log in'

    expect(current_path).to eq('/login')
    expect(page).to have_content("Incorrect Password or Email")

  end



end
