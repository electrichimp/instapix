class Order < ApplicationRecord
  enum status: %i[pending paid printing ready_to_deliver delivered cancelled]
  belongs_to :user
<<<<<<< HEAD
=======
  enum state: %i[pending paid printing ready_to_deliver delivered cancelled]
>>>>>>> dcdfac02e5c9cbdcc6f4ac4f13f29b1807b1ef17
  has_many :prints
end
