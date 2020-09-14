require 'rails_helper'

RSpec.describe "When I click Login" do
  it "Then I am taken to the logging page where General user can log in with valid credentials" do
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

  it "Then I am taken to the logging page where Merchant user can log in with valid credentials" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 1 )

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'

    expect(current_path).to eq('/merchant/dashboard')
    expect(page).to have_content("You have been logged in")

  end

  it "Then I am taken to the logging page where Admin user can log in with valid credentials" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 2 )

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'

    expect(current_path).to eq('/admin/dashboard')
    expect(page).to have_content("You have been logged in")

  end

  it "Then I am taken to the logging page where I Get error when wrong password used" do
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

  it "Then I am taken to the logging page where I Get error when wrong password used" do
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

  it "Then I am taken to the general user profile page if I am already logged in" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 0 )

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'
    visit '/login'

    expect(current_path).to eq('/profile')
    expect(page).to have_content("You are already logged in")
  end

  it "Then I am taken to the merchant user profile page if I am already logged in" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 1 )

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'
    click_on 'login'

    expect(current_path).to eq('/merchant/dashboard')
    expect(page).to have_content("You are already logged in")
  end

  it "Then I am taken to the admin user profile page if I am already logged in" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 2 )

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'
    click_on 'login'

    expect(current_path).to eq('/admin/dashboard')
    expect(page).to have_content("You are already logged in")
  end






end
