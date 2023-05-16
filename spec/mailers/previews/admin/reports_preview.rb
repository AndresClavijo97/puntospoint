# Preview all emails at http://localhost:3000/rails/mailers/admin/reports
class Admin::ReportsPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/admin/reports/send_daily_purchases
  def send_daily_purchases
    Admin::ReportsMailer.send_daily_purchases(purchases: [])
  end
end
