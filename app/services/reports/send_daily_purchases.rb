module Reports
  # this service send a daily report with all purchases from yesterday
  class SendDailyPurchases
    def call
      yerterday = 1.day.ago
      starts_at = yerterday.at_beginning_of_day
      ends_at = yerterday.end_of_day
      purchases = Purchase.where(created_at: starts_at..ends_at).to_a
      Admin::ReportsMailer.send_daily_purchases(purchases: purchases).deliver_later

      [true, { message: 'Proccess executed successfully' }]
    rescue StandardError
      # TODO: move all ocurrencies to i18n
      [false, { message: 'If a problem has occurred, report it to support' }]
    end
  end
end
