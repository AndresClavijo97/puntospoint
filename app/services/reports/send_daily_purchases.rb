module Reports
  # this service send a daily report with all purchases from yesterday
  class SendDailyPurchases
    def self.call
      yerterday = 1.day.ago
      starts_at = yerterday.at_beginning_of_day
      ends_at = yerterday.end_of_day
      purchases = Purchase.where(created_at: starts_at..ends_at)
      Admin::ReportsMailer.send_daily_purchases(purchases: purchases).deliver_now
    end
  end
end
