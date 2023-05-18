module Purchases
  class SearchPurchases
    class MissingParamsError < StandardError; end

    def initialize(params)
      @params = params
      @purchases = Purchase.includes(product: :categories)
    end

    def call
      validate_params
      filter_by_dates if dates_present?
      filter_by_category if form.category_id.present?
      filter_by_client if form.client_id.present?
      filter_by_admin if form.user_id.present?

      [true, { purchases: @purchases, message: 'Proccess executed successfully' }]
    rescue MissingParamsError => e
      [false, { purchases: @purchases, message: e.message }]
    rescue StandardError
      # TODO: move all ocurrencies to i18n
      [false, { message: 'If a problem has occurred, report it to support' }]
    end

    private

    def validate_params
      raise MissingParamsError, 'Missing params to search' if form.empty?
    end

    def dates_present?
      form.from_date.present? && form.to_date.present?
    end

    def filter_by_dates
      @purchases = @purchases.where(created_at: form.from_date...form.to_date)
    end

    def filter_by_category
      @purchases = @purchases.where(product: { categories_products: { category_id: form.category_id }})
    end

    def filter_by_client
      @purchases = @purchases.where(client_id: form.client_id)
    end

    def filter_by_admin
      @purchases = @purchases.joins(:product).where(product: { creator_id: form.user_id })
    end

    def form
      @form ||= V1::Purchases::SearchForm.new(@params)
    end
  end
end
