class Payment < ApplicationRecord
  belongs_to :shop

  mount_uploader :image, PaymentUploader

end
