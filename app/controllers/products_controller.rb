class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def index
    @products = Product.order(created_at: :desc).last(20)
    respond_to do |format|
       format.html { render }
       format.json { render json: @products }
   end
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
    @category = @product.category
    respond_to do |format|
       format.html { render }
       format.json { render json: @product }
   end

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
   @product.user = current_user

    if @product.save
      if @product.tweet_it
       client = Twitter::REST::Client.new do |config|
         config.consumer_key        = ENV["TWITTER_API_KEY"]
         config.consumer_secret     = ENV["TWITTER_API_SECRET"]
         config.access_token        = current_user.twitter_token
         config.access_token_secret = current_user.twitter_secret
       end

       client.update "#{@product.title} #{product_url(@product)}"
     end
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
    params.require(:product).permit([:title, :description, :price, :category_id, :tweet_it])
    # params.require(:question).permit([:title, :body])
  end





end
