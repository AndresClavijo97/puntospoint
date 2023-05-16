class Product < ApplicationRecord
  has_many :purchases, class_name: 'Purchase', dependent: :destroy
  has_and_belongs_to_many :categories, class_name: 'Category'

  has_many_attached :images
end
