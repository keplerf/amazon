require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "Validations" do
    it "requires a title" do
      prod = Product.new
      prod.valid?
      expect(prod.errors).to have_key(:title)
    end

    it "requires a price" do
      prod = Product.new
      prod.valid?
      expect(prod.errors).to have_key(:price)
    end

    it "requires a description" do
      prod = Product.new
      prod.valid?
      expect(prod.errors).to have_key(:description)
    end
    it "title  must be unique" do
      Product.create({title: "valid title", price: 20, description: "descrition long text here"})
      prod = Product.new title: "valid title"
      prod.valid?
      expect(prod.errors).to have_key(:title)
    end

    it "price must be bigger then 0" do
      prod = Product.new price: 400000000
      prod.valid?
      expect(prod.errors).to have_key(:price)

    end

  end
end
