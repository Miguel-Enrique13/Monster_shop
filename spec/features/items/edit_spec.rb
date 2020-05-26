require 'rails_helper'

RSpec.describe "As a Visitor" do
  describe "When I visit an Item Show Page" do
    describe "and click on edit item" do
      it 'I can see the prepopulated fields of that item' do
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

        visit "/items/#{@tire.id}"

        expect(page).to have_link("Edit Item")

        click_on "Edit Item"

        expect(current_path).to eq("/items/#{@tire.id}/edit")
        expect(page).to have_link("Gatorskins")
        expect(find_field('Name').value).to eq "Gatorskins"
        expect(find_field('Price').value).to eq '$100.00'
        expect(find_field('Description').value).to eq "They'll never pop!"
        expect(find_field('Image').value).to eq("https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588")
        expect(find_field('Inventory').value).to eq '12'
      end

      it 'I can change and update item with the form' do
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

        visit "/items/#{@tire.id}"

        click_on "Edit Item"

        fill_in 'Name', with: "GatorSkins"
        fill_in 'Price', with: 110
        fill_in 'Description', with: "They're a bit more expensive, and they kinda do pop sometimes, but whatevs.. this is retail."
        fill_in 'Image', with: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588"
        fill_in 'Inventory', with: 11

        click_button "Update Item"

        expect(current_path).to eq("/items/#{@tire.id}")
        expect(page).to have_content("GatorSkins")
        expect(page).to_not have_content("Gatorskins")
        expect(page).to have_content("Price: $110")
        expect(page).to have_content("Inventory: 11")
        expect(page).to_not have_content("Inventory: 12")
        expect(page).to_not have_content("Price: $100")
        expect(page).to have_content("They're a bit more expensive, and they kinda do pop sometimes, but whatevs.. this is retail.")
        expect(page).to_not have_content("They'll never pop!")
      end

      it 'I get a flash message if entire form is not filled out' do
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

        visit "/items/#{@tire.id}"

        click_on "Edit Item"

        fill_in 'Name', with: ""
        fill_in 'Price', with: 110
        fill_in 'Description', with: "They're a bit more expensive, and they kinda do pop sometimes, but whatevs.. this is retail."
        fill_in 'Image', with: ""
        fill_in 'Inventory', with: 11

        click_button "Update Item"

        expect(page).to have_content("Name can't be blank and Image can't be blank")
        expect(page).to have_button("Update Item")
      end
    end
  end
end
