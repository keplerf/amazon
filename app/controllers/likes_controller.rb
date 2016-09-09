class LikesController < ApplicationController

  def create
    product = Product.find params[:product_id]
    review = Review.find params[:review_id]
    like = Like.new user: current_user , review: review

    respond_to do |format|
      if like.save
        format.html { redirect_to product_path(product), notice: "Thanks for favoriting"}
        format.js { update_like}
      else
        format.html { redirect_to product_path(product), alert: like.errors.full_messages.join(", ")}

      end
    end
  end

  def destroy
    product = Product.find params[:product_id]
    like= Like.find params[:id]
    like.destroy
    respond_to do |format|
      format.html { redirect_to product_path(product), notice: "Thanks for favoriting" }
      format.js { render }
    end
  end

end
