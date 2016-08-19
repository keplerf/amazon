class ReviewsController < ApplicationController

  def create
    @review = Review.new params.require(:review).permit(:body,:star)
    @product = Product.find params[:product_id]
    @review.product = @product

    if @review.save
    # we redirect to the question show page
      redirect_to product_path(@product), notice: "Answer created!"
    else
      flash[:alert] = "please fix errors below"
      render "/products/show"
    end

  end

  def destroy
    # render json: params
    q = Product.find params[:product_id]
    a = Review.find params[:id]
    a.destroy
    redirect_to product_path(q), notice: "Answer deleted"



  end
end
