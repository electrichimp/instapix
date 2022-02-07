class Order < ApplicationRecord
  enum state: %i[pending paid printing ready_to_deliver delivered cancelled]
  belongs_to :user
  has_many :prints, dependent: :delete_all

  # geocoder
  geocoded_by :shipping_address
  after_validation :geocode, if: :will_save_change_to_shipping_address?
end
