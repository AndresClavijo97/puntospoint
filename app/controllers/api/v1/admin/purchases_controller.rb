class Api::V1::Admin::PurchasesController < Api::BaseController
  authorize_resource

  def search
    # debugger
    success, data = Purchases::SearchPurchases.new(search_params).call

    if success
      render json: data[:purchases], status: :ok
    else
      render json: { errors: data[:message] }, status: :internal_server_error
    end
  end

  def granularity
    success, data = Purchases::GroupAndCountByGranularity.new(search_params).call

    if success
      render json: data[:purchases], status: :ok
    else
      render json: { errors: data[:message] }, status: :internal_server_error
    end
  end

  private

  def search_params
    params.require(:form).permit(:category_id, :user_id, :from_date, :to_date, :granularity)
  end
end
