class Purchase < ApplicationRecord
  attr_accessor :skip_first_purchase_email

  belongs_to :client, class_name: 'Client'
  belongs_to :product, class_name: 'Product'

  before_create :calculate_total
  after_create :send_first_purchase_email, if: :first_purchase?

  private

  def send_first_purchase_email
    return if skip_first_purchase_email

    creator = product.creator
    administrators = User.admin.where.not(id: creator.id).pluck(:email)

    Purchase.transaction do
      return unless first_purchase?

      Admin::NotificationMailer.first_purchase(
        creator: creator,
        administrators: administrators
      ).deliver_later
    end
  end

  def calculate_total
    self.total = product.price * quantity
  end

  def first_purchase?
    product.purchases.limit(2).count == 1
  end
end
