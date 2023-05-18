class Api::BaseController < ApplicationController
  before_action :set_default_format
  before_action :authenticate_token!

  rescue_from ActiveRecord::RecordNotFound do
    render json: { errors: ['Records not found'] }, status: :unauthorized
  end

  rescue_from CanCan::AccessDenied do |exception|
    render json: { errors: [exception.message] }, status: :unauthorized
  end

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

  def current_ability
    @current_ability ||= Ability.new(@current_user)
  end
end
