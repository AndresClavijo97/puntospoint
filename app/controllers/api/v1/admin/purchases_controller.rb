class Api::V1::Admin::PurchasesController < ApplicationController
  def search
    success, data = V1::Purchases::SearchPurchase.new.call(search_params)

    if success
      render json: data[:purchases], status: :ok
    else
      render json: { errors: data[:message] }, status: :internal_server_error
    end
  end

  private

  def search_params
    params.require(:form).permit(:category_id, :user_id, :from_date, :to_date)
  end
end
