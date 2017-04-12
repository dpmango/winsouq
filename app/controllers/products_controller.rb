class ProductsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create

    @shop = Shop.find(params[:shop_id])

    if current_user
      @product = @shop.products.build(product_params)
      if @product.save
        redirect_to edit_shop_path(@shop), notice: 'Product was successfully created.'
      else
        redirect_back(fallback_location: root_path)
        flash[:alert] = 'Error creating product'
      end
    else
  		redirect_to new_user_session_path
    end

  end

  def update
    @shop = Shop.find(params[:shop_id])

    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to edit_shop_path(@shop), notice: 'Product was successfully updated.'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'Error updating product'
    end

  end

  def destroy
  end

  private

    def correct_user
      @targetShop = current_user.shops.find(params[:shop_id])
      if @targetShop.nil?
        redirect_back(fallback_location: root_path)
        flash[:alert] = 'You dont have an acess to this page'
      end
    end

    def product_params
      params.require(:product).permit(
        :shop_id, :image, :name, :price, :description
      )
    end

end
