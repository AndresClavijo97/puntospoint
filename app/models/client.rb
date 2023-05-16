class Client < ApplicationRecord
  has_many :purchases, class_name: 'Purchase'
end
