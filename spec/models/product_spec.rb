require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'validates when all four properties are valid' do
      @category = Category.create(name: 'Gardening')
      @product = Product.create(name: 'Trowel', category: @category, quantity: 60, price: 1000)
      @product.save!

      expect(@product).to be_valid
    end
    it 'should not validate when no name exists' do
      @category = Category.create(name: 'Gardening')
      @product = Product.create(name: nil, category: @category, quantity: 60, price: 1000)

      expect(@product.errors.full_messages).to include "Name can't be blank"
    end
    it 'should not validate when no price exists' do
      @category = Category.create(name: 'Gardening')
      @product = Product.create(name: 'Trowel', category: @category, quantity: 60, price: nil)

      expect(@product.errors.full_messages).to include "Price can't be blank"
    end
    it 'should not validate when no quantity exists' do
      @category = Category.create(name: 'Gardening')
      @product = Product.create(name: 'Trowel', category: @category, quantity: nil, price: 1000)

      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end
    it 'should not validate when no category exists' do
      @category = Category.create(name: 'Gardening')
      @product = Product.create(name: 'Trowel', category: nil, quantity: 60, price: 1000)

      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end
