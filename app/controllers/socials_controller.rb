class SocialsController < ApplicationController
  before_action :set_social, only: [:destroy]
  before_action :authenticate_user!, only: [:destroy]
  before_action :correct_user, only: [:destroy]

  def destroy
    @social.destroy
    respond_to do |format|
      format.html { redirect_to edit_shop_url(@social.shop), notice: 'Social media account was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social
      @social = Social.find(params[:id])
    end

    def correct_user
      @targetSocial = Social.find(params[:id])
      @targetShop = Shop.find_by_id(@targetSocial.shop_id)
      if @targetShop.user != current_user
        redirect_back(fallback_location: root_path)
        flash[:alert] = 'You dont have an acess this action'
      end
    end
end
