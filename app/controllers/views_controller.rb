class ViewsController < ApplicationController

  def index
    # get viewed items
    if current_user
      @shops = Shop.joins(:views).where("views.user_id = #{current_user.id}").order('views.updated_at DESC')
    end

  end
end
