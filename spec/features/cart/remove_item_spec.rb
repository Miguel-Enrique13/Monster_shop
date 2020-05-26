require 'rails_helper'

RSpec.describe 'Cart show' do
  describe 'When I have added items to my cart' do
    describe 'and visit my cart path' do
      before(:each) do
        @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
        @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
        visit "/items/#{@paper.id}"
        click_on "Add To Cart"
        visit "/items/#{@tire.id}"
        click_on "Add To Cart"
        visit "/items/#{@pencil.id}"
        click_on "Add To Cart"
        @items_in_cart = [@paper,@tire,@pencil]
      end

      it 'there is a button to delete the item next to each item' do
        visit "/cart"

        @items_in_cart.each do |item|
          within "#cart-item-#{item.id}" do
            expect(page).to have_link("Remove")
          end
        end
      end

      it 'I can delete individual items from my cart' do
        visit "/cart"

        within "#cart-item-#{@tire.id}" do
          click_on "Remove"
        end

        expect(current_path).to eq("/cart")
        expect(page).to_not have_css("#cart-item-#{@tire.id}")
        expect(page).to have_css("#cart-item-#{@pencil.id}")
        expect(page).to have_css("#cart-item-#{@paper.id}")
      end
    end
  end
end
