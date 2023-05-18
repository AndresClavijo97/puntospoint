module V1
  module Purchases
    class SearchForm < GenericSearchForm
      attribute :from_date, type: Date
      attribute :to_date, type: Date
      attribute :user_id
      attribute :client_id
      attribute :category_id
    end
  end
end
