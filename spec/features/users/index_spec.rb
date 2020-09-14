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
end
