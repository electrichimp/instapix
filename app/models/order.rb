class Order < ApplicationRecord
  enum state: %i[pending paid printing ready_to_deliver delivered cancelled]
  belongs_to :user
  has_many :prints, dependent: :delete_all
end
