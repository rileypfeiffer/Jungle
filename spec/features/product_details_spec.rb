require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )      
    end
  end

  scenario "They can navigate to a product's details" do
    # ACT
    visit root_path
    first('.product').click_on('Details')

    # DEBUG / VERIFY

    expect(page).to have_css('.product-detail')
                .and have_text('Name')
                .and have_text('Description')
                .and have_text('Quantity')
                .and have_text('Price')

    save_screenshot
  end
end