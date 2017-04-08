class FavoriteShopsController < ApplicationController

  before_action :set_shop
  before_action :authenticate_user!, only: [:create, :destroy]
  
  def create
    if Favorite.create(favorited: @shop, user: current_user)
      redirect_to @shop, notice: 'shop has been favorited'
    else
      redirect_to @shop, alert: 'Something went wrong...'
    end
  end

  def destroy
    Favorite.where(favorited_id: @shop.id, user_id: current_user.id).first.destroy
    redirect_to @shop, notice: 'shop is no longer in favorites'
  end

  private

  def set_shop
    @shop = Shop.find(params[:shop_id] || params[:id])
  end

end
