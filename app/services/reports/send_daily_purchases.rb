module Reports
  # this service send a daily report with all purchases from yesterday
  class SendDailyPurchases
    extend self

    def call
      yerterday = 1.day.ago
      starts_at = yerterday.at_beginning_of_day
      ends_at = yerterday.end_of_day
      purchases = Purchase.where(created_at: starts_at..ends_at)
      Admin::ReportsMailer.with(purchases:).send_daily_purchases.deliver_later
    end
  end
end
