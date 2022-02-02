class Order < ApplicationRecord
  enum status: %i[pending paid printing ready_to_deliver delivered cancelled]
  belongs_to :user
  has_many :prints
end
