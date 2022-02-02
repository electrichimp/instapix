class Product < ApplicationRecord
  enum category: [ :book, :photo, :frame ]
end
