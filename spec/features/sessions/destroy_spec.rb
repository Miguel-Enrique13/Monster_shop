require 'rails_helper'

RSpec.describe "When I click logout" do
  it "I am taken to the welcome page and I am logged out" do
    user = User.create!(name: 'Bob', address: "567 Road", city: 'Los Angeles', state: 'California', zip: '678987', email: 'andy@gmail.com', password: 'password', password_confirmation: 'password', role: 2 )

    visit items_path

    click_on 'login'

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on 'log in'

    click_on 'Log out'

    expect(current_path).to eq(root_path)
  end
end
