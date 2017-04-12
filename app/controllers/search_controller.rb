class SearchController < ApplicationController

  def search
    if params[:q].nil?
      @shops = []
    else
      @shops = Shop.search params[:q]
    end
  end

end
