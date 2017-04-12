class FavoriteProductsController < ApplicationController
  before_action :set_product, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    # show all favorite products
    @favorited = Favorite.where(favorited_type: "Product", user_id: current_user.id)
    @favoritedArr = []

    @favorited.each do |fav|
      @favoritedArr.push(fav.favorited_id)
    end
    
    @shopProducts = Product.where(id: @favoritedArr)

  end

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
