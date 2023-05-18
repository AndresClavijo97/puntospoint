class Api::V1::Admin::ProductsController < Api::BaseController
  authorize_resource

  def most_purchased
    success, data = Products::MostPurchasedQuery.new.call

    if success
      render json: data[:results], status: :ok
    else
      render json: { errors: data[:message] }, status: :internal_server_error
    end
  end

  def three_high_profit
    success, data = Products::ThreeHighProfitQuery.new.call

    if success
      render json: data[:results], status: :ok
    else
      render json: { errors: data[:message] }, status: :internal_server_error
    end
  end
end
