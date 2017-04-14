class PaymentsController < ApplicationController
  before_action :set_payment, only: [:destroy]
  before_action :authenticate_user!, only: [:destroy]
  before_action :correct_user, only: [:destroy]

  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to edit_shop_url(@payment.shop), notice: 'Payment method was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def correct_user
      @targetPayment = Payment.find(params[:id])
      @targetShop = Shop.find_by_id(@targetPayment.shop_id)
      if @targetShop.user != current_user
        redirect_back(fallback_location: root_path)
        flash[:alert] = 'You dont have an acess this action'
      end
    end
end
