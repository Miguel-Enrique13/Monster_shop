require 'rails_helper'

RSpec.describe 'review edit and update', type: :feature do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
  end
  describe "when I visit the item show page" do
    it "I see a link called Edit next to each review" do
      review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      review_2 = @chain.reviews.create(title: "Cool shop!", content: "They have cool bike stuff and I'd recommend them to anyone.", rating: 4)
      review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 1)
      review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)

      reviews = [review_1,review_2,review_3,review_4,review_5]

      visit "/items/#{@chain.id}"

      reviews.each do |review|
        within "#review-#{review.id}" do
          expect(page).to have_link("Edit")
        end
      end
    end

    it "I can edit a review when I fill in all of the fields" do
      review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      title = "Nice Bike Shop!"
      content = "It's great!"
      rating = 4

      visit "/items/#{@chain.id}"

      within "#review-#{review_1.id}" do
        click_on "Edit"
      end

      expect(current_path).to eq("/reviews/#{review_1.id}/edit")
      expect(find_field(:title).value).to eq(review_1.title)
      expect(find_field(:content).value).to eq(review_1.content)
      expect(find_field(:rating).value).to eq(review_1.rating.to_s)

      fill_in :title, with: title
      fill_in :content, with: content
      fill_in :rating, with: rating

      click_on "Update Review"

      expect(current_path).to eq("/items/#{@chain.id}")
      within "#review-#{review_1.id}" do
        expect(page).to have_content(title)
        expect(page).to have_content(content)
        expect(page).to have_content(rating)
      end
    end

    it "I can edit a review when I fill in just some of the fields" do
      review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      title = "Nice Bike Shop!"

      visit "/items/#{@chain.id}"

      within "#review-#{review_1.id}" do
        click_on "Edit"
      end

      fill_in :title, with: title

      click_on "Update Review"

      expect(current_path).to eq("/items/#{@chain.id}")
      within "#review-#{review_1.id}" do
        expect(page).to have_content(title)
        expect(page).to_not have_content(review_1.title)
        expect(page).to have_content(review_1.content)
        expect(page).to have_content(review_1.rating)
      end
    end

  end
end
