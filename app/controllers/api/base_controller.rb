class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_default_format
  before_action :authenticate_token!

  private

  def set_default_format
    request.format = :json
  end

  def authenticate_token!
    payload = Authentication::JsonWebToken.decode(auth_token)
    @current_user = User.find(payload['user_id'])
  rescue JWT::ExpiredSignature
    render json: { errors: ['Expired auth token'] }, status: :unauthorized
  rescue JWT::DecodeError
    render json: { errors: ['Invalid auth token'] }, status: :unauthorized
  end

  def auth_token
    @auth_token ||= request.headers[:authorization].split.last
  end
end
