class ReviewsController < ApplicationController

  def create
    @review = Review.new params.require(:review).permit(:body,:star)
    @product = Product.find params[:product_id]
    @review.product = @product
    respond_to do |format|
      if @review.save
      # we redirect to the question show page
      # puts "dsddsdsdsds"
        format.html {redirect_to product_path(@product), notice: "review created!"}
        format.js { render :create_review }

      else
        flash[:alert] = "please fix errors below"
        format.html {render "/products/show"}
        format.js { render :create_failure }
      end
    end

  end

  def destroy
    respond_to do |format|
      # render json: params
      q = Product.find params[:product_id]
      a = Review.find params[:id]
      a.destroy
      format.html { redirect_to product_path(q), notice: "Answer deleted" }
      format.js { render }
    end



  end
end
