class Product < ApplicationRecord
  has_many :purchases, class_name: 'Purchase'
  has_and_belongs_to_many :categories, class_name: 'Category'
end
