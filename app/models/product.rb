class Product < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :purchases, class_name: 'Purchase', dependent: :destroy
  has_and_belongs_to_many :categories, class_name: 'Category'

  has_many_attached :images
  has_paper_trail

  validates :name, uniqueness: true
end
