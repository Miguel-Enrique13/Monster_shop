require 'rails_helper'

describe 'I checkout with a full cart' do
  before :each do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    @bob = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password' )

    visit '/login'
    fill_in :email, with: @bob.email
    fill_in :password, with: @bob.password
    click_on 'log in'


    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"
  end

  it "I am taken to the order page" do
    visit '/cart'

    click_on 'Checkout'

    expect(current_path).to eq('/orders/new')

    fill_in :name, with: @bob.name
    fill_in :address, with: @bob.address
    fill_in :city, with: @bob.city
    fill_in :state, with: @bob.state
    fill_in :zip, with: @bob.zip

    click_on 'Create Order'

    expect(page).to have_content('Order has been created')
    expect(page).to have_content('Pending')

    visit('/profile/orders')

    expect(page).to have_content(@bob.orders.first.created_at)
    expect(page).to have_content(@bob.orders.first.updated_at)
    expect(page).to have_content(@bob.orders.first.quantity)
    expect(page).to have_content(@bob.orders.first.grandtotal)
    expect(page).to have_content(@bob.orders.first.status)
    expect(page).to have_link("##{@bob.orders.first.id}")
  end
end
