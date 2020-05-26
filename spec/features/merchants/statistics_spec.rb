# As a visitor
# When I visit a merchant's show page
# I see statistics for that merchant, including:
# - count of items for that merchant
# - average price of that merchant's items
# - Distinct cities where my items have been ordered
require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a user' do
    before :each do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      @order_2 = Order.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204)
      @order_3 = Order.create!(name: 'Mike', address: '123 Dao St', city: 'Denver', state: 'CO', zip: 80210)

      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
      @order_2.item_orders.create!(item: @dog_bone, price: @dog_bone.price, quantity: 2)
      @order_2.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 2)
      @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_3.item_orders.create!(item: @dog_bone, price: @dog_bone.price, quantity: 5)
    end

    it 'I can see a merchants statistics' do
      visit "/merchants/#{@brian.id}"

      within ".merchant-stats" do
        expect(page).to have_content("Number of Items: 2")
        expect(page).to have_content("Average Price of Items: $15")
        within ".distinct-cities" do
          expect(page).to have_content("Cities that order these items:")
          expect(page).to have_content("Hershey")
          expect(page).to have_content("Denver")
        end
      end


    end
  end
end
