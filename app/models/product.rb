class Product < ApplicationRecord
  belongs_to :shop
  belongs_to :category

end
