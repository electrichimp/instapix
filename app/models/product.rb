class Product < ApplicationRecord
  enum category: %i[book photo frame]
  has_one_attached :photo
  has_many_attached :photos
end
