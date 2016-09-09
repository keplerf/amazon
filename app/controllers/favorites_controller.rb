class FavoritesController < ApplicationController

  def create
    product = Product.find params[:product_id]
    favorite = Favorite.new user: current_user, product: product
    if favorite.save
      redirect_to product_path(product), notice: "Thanks for favoriting"
      
    else
      redirect_to product_path(product), alert: favorite.errors.full_messages.join(", ")
    end

  end

  def destroy
    product = Product.find params[:product_id]
    favorite = Favorite.find params[:id]
    favorite.destroy
    redirect_to  product_path(product), notice: "Product unfavorite"

  end
end
