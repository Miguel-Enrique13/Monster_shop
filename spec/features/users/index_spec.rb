require 'rails_helper'

RSpec.describe 'Navigation bar', type: :feature do
  it "I can home page, items, merchants, cart, login and register link" do
    visit root_path

    expect(page).to have_link('Home')
    expect(page).to have_link('All Items')
    expect(page).to have_link('All Merchants')
    expect(page).to have_link('Cart')
    expect(page).to have_link('login')
  end

  it "I can click each link " do
    visit root_path

    click_on('Home')
    expect(current_path).to eq(root_path)

    click_on('All Items')
    expect(current_path).to eq('/items')

    click_on('All Merchants')
    expect(current_path).to eq('/merchants')

    click_on('Cart')
    expect(current_path).to eq('/cart')

    click_on('login')
    expect(current_path).to eq(login_index_path)
  end

  it "I see 'profile' and 'logout' on the nav bar when I log in as a general user" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 0 )

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'

    expect(page).to have_link('Profile')
    expect(page).to have_link('Log out')
  end

  it "I see 'merchant' on the nav bar when I log in as a merchant user" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 1 )

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'

    expect(page).to have_link('Merchant')
  end

  it "I see 'Admin' and 'All Users' on the nav bar when I log in as a general user" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 2 )

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'

    expect(page).to have_link('All Users')
    expect(page).to have_link('Admin')

    click_on("All Users")
    expect(current_path).to eq('/admin/users')
  end


end
