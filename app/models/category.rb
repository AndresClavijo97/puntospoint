class Category < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_and_belongs_to_many :products, class_name: 'Product'

  has_paper_trail
end
