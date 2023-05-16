class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { basic: 1, admin: 2 }

  has_many :categories, class_name: 'Category'
  has_many :products, class_name: 'Product'
end
