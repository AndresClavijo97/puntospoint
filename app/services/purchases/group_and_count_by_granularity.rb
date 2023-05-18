module Purchases
  class GroupAndCountByGranularity
    class MissingParamsError < StandardError; end
    class SearchServiceError < StandardError; end

    GRANULARITIES = {
      hour: 'hour',
      day: 'day',
      week: 'week',
      year: 'year'
    }.freeze

    def initialize(params, search_service = Purchases::SearchPurchases)
      @params = params
      @service = search_service.new(params)
    end

    def call
      search_purchases
      validate_params
      group_purchase_counts_by_granularity

      [true, { purchases: @purchases, message: 'Proccess executed successfully' }]
    rescue MissingParamsError => e
      [false, { message: e.message }]
    rescue SearchServiceError => e
      [false, { message: e.message }]
    rescue StandardError
      # TODO: move all ocurrencies to i18n
      [false, { message: 'If a problem has occurred, report it to support' }]
    end

    private

    def validate_params
      raise MissingParamsError, 'Missing granularity param to search' if @params[:granularity].blank?
    end

    def search_purchases
      success, data = @service.call
      raise SearchServiceError, data[:message] unless success

      @purchases = data[:purchases]
    end

    def group_purchase_counts_by_granularity
      granularity = GRANULARITIES[@params[:granularity].to_sym] || GRANULARITIES[:year]
      @purchases = @purchases.group("date_trunc('#{granularity}', purchases.created_at)").count
    end
  end
end
