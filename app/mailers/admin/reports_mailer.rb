module Admin
  # Admin::ReportsMailer
  class ReportsMailer < ApplicationMailer
    default to: -> { User.admin.pluck(:email) }

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.admin.reports_mailer.send_daily_purchases.subject
    #
    def send_daily_purchases(options)
      @purchases = options[:purchases]
      bootstrap_mail subject: 'Daily report of Purchases'
    end
  end
end
