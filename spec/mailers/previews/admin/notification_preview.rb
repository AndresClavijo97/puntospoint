# Preview all emails at http://localhost:3000/rails/mailers/admin/notification
class Admin::NotificationPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/admin/notification/first_purchase
  def first_purchase
    Admin::NotificationMailer.first_purchase
  end

end
