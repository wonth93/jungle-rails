require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do
    
    it 'generate a valid product' do
      @category = Category.new
      @product = Product.new(name: "Testing", price: 40, quantity: 5, category: @category)
      expect(@product).to be_valid
    end

    it 'generate an error message when there is no name' do
      @category = Category.new
      @product = Product.new(price: 40, quantity: 5, category: @category)
      expect(@product.name).to be_nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to match(/Name can't be blank/)
    end

    it 'generate an error message when there is no price' do
      @category = Category.new
      @product = Product.new(name: 'ABC', quantity: 5, category: @category)
      expect(@product.price).to be_nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to match(/Price cents is not a number/)
    end

    it 'generate an error message when there is no quantity' do
      @category = Category.new
      @product = Product.new(name: 'ABC', price: 5, category: @category)
      expect(@product.quantity).to be_nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[0]).to match(/Quantity can't be blank/)
    end

    it 'generate an error message when there is no category' do
      @category = Category.new
      @product = Product.new(price: 40, quantity: 5, name: 'ABC')
      expect(@product.category).to be_nil
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages[1]).to match(/Category can't be blank/)
    end

  end

end
