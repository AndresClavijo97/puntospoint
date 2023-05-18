module Products
  # Products::MostPurchasedQuery
  class MostPurchasedQuery
    def call
      categories = Category.includes(:purchases)
      results = {}
      categories.each do |category|
        @product = category.products
                           .joins(:purchases)
                           .group('products.id')
                           .order('COUNT(purchases.id) DESC')
                           .first

        results[category.name] = product_name
      end

      [true, { results: results, message: 'Proccess executed successfully' }]
    rescue StandardError
      [false, { message: 'If a problem has occurred, report it to support' }]
    end

    private

    def product_name
      @product.present? ? @product.name : 'there are no purchases for this category'
    end
  end
end
