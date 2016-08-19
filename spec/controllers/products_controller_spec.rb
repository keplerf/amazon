require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)

    end
    it "instantiates a new product instance variable" do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end

  end


  describe "#create" do
    context "with valid parameters" do

      def valid_request
        post :create, params: { product: {title: "campaign title",
                                           description: "hello",
                                           image: "/image/test.jpg",
                                           tbn_image: "/image/test.jpg",
                                           price: 1 + rand(100)
                                           } }
      end

      it "saves a record to the database" do
        count_before = Product.count
        valid_request
        count_after = Product.count
        expect(count_after).to eq(count_before + 1)

      end

      it "redirects to the product show page" do
        valid_request
        expect(response).to redirect_to(product_path(Product.last))

      end


    end

    context "with invalid parameters" do
      def invalid_request
        post :create, params: {product: {title: ""}}

      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "doesn't save the record to the database" do
        count_before = Product.count
        invalid_request
        count_after = Product.count
        expect(count_after).to eq(count_before)
      end

    end
  end


  describe "#edit" do
    it "renders the edit template" do
      product  = FactoryGirl.create(:product)
      get :edit, params: { id: product.id }
      expect(response).to render_template(:edit)
    end

    it "save the instance variable" do
      product  = FactoryGirl.create(:product)
      product.title = "no title"
      expect(product.title).to eq("no title")
    end

    it "redicet to product page" do
      product  = FactoryGirl.create(:product)
      get :edit, params: { id: product.id }
      expect(response).to redirect_to(:product_path)
    end

  end

  describe "#update" do
    context 'with valid params' do
       it 'saves an update to the database' do
        record = FactoryGirl.create(:product)
        record.description = "this is an updated description"
        patch :update, params: { id: record.id, product: {
                                            description: record.description } }
        expect(Product.last).to eq(record)
       end
    end
  end

  describe '#destroy' do
    it 'removes a record from the database' do
      count = Product.count
      record = FactoryGirl.create(:product)
      delete :destroy, params: { id: record.id }
      expect(Product.count).to eq(count)
    end

    it 'redirects to index' do
      record = FactoryGirl.create(:product)
      delete :destroy, params: { id: record.id }
      expect(response).to redirect_to(products_path)
    end
  end



end
