class StaticController < ApplicationController

  def index
    @categories = Category.all
  end

end
