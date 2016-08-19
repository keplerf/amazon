class ProductsController < ApplicationController

  def new

    @product = Product.new


  end

  def index
    @products = Product.order(created_at: :desc).last(20)
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
    @category = @product.category

  end

  def edit
    @product = Product.find params[:id]

  end

  def update
    @product = Product.find params[:id]
    if @product.update question_params
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def create

   product_params  = question_params
    @product       = Product.new product_params

    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end

  end

  def destroy
    product = Product.find params[:id]
    product.destroy
    redirect_to products_path
  end

  private

  def question_params
    params.require(:product).permit([:title, :description, :price, :category_id])
    # params.require(:question).permit([:title, :body])
  end





end
