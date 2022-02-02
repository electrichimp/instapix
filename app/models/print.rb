class Print < ApplicationRecord
  belongs_to :order
  belongs_to :product

  has_one_attached :cover_photo
  has_many_attached :photos
end
