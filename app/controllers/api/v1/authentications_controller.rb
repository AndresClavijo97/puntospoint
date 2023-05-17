class Api::V1::AuthenticationsController < Api::BaseController
  skip_before_action :authenticate_token!

  def create
    user = User.find_by!(email: authentication_params[:email])
    if user.valid_password? authentication_params[:password]
      render json: { token: Authentication::JsonWebToken.encode(user_id: user.id) }, status: :ok
    else
      render json: { errors: ['Invalid email or password'] }, status: :unauthorized
    end
  end

  private

  def authentication_params
    params.require(:authentication).permit(:email, :password)
  end
end
