class Purchase < ApplicationRecord
  belongs_to :client, class_name: 'Client'
  belongs_to :product, class_name: 'Product'
end
