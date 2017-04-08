class FavoriteProductsController < ApplicationController
  before_action :set_product
  before_action :authenticate_user!, only: [:create, :destroy]


  def create
    if Favorite.create(favorited: @product, user: current_user)
      redirect_to @product.shop, notice: 'product has been favorited'
    else
      redirect_to @product.shop, alert: 'Something went wrong...'
    end
  end

  def destroy
    Favorite.where(favorited_id: @product.id, user_id: current_user.id).first.destroy
    redirect_to @product.shop, notice: 'product is no longer in favorites'
  end

  private

  def set_product
    @product = Product.find(params[:product_id] || params[:id])
  end

end
