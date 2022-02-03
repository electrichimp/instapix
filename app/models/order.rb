class Order < ApplicationRecord
  belongs_to :user
  enum state: %i[pending paid printing ready_to_deliver delivered cancelled]
  has_many :prints
end
