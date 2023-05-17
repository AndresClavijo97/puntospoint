class Admin::NotificationMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin.notification_mailer.first_purcharse.subject
  #
  def first_purchase(options)
    @creator = options[:creator]
    @administrators = options[:administrators]

    bootstrap_mail(
      to: @creator.email,
      cc: @administrators,
      subject: 'First purchase notification'
    )
  end
end
