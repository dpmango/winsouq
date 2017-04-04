class StaticController < ApplicationController

  def index
    @categories = Category.all
  end

  def about
    @content = Page.find_by_id(1)
  end

  def contact
    @content = Page.find_by_id(2)
  end

  def faq
    @content = Page.find_by_id(3)
  end

  def terms
    @content = Page.find_by_id(4)
  end

end
