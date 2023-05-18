module Products
  # Products::ThreeHighProfitQuery
  class ThreeHighProfitQuery
    def initialize
      @results = Hash.new { |h, k| h[k] = [] }
    end

    def call
      Category.includes(:purchases).each do |category|
        products = category.products
                           .joins(:purchases)
                           .select('products.*, SUM(purchases.total) AS total_revenue')
                           .group('products.id')
                           .order('total_revenue DESC')
                           .limit(3)

        serialize_response(category, products)
      end

      [true, { results: @results, message: 'Proccess executed successfully' }]
    rescue StandardError
      [false, { message: 'If a problem has occurred, report it to support' }]
    end

    private

    def serialize_response(category, products)
      products.each do |product|
        @results[category.name] << { name: product_name(product), total_revenue: product.total_revenue }
      end
    end

    def product_name(product)
      product.present? ? product.name : 'there are no purchases for this category'
    end
  end
end
