class V1::BaseController < ApplicationController 
  respond_to :json

  before_filter :authenticate!

  helper_method :current_user

private

  def authenticate!
    token = request.headers['Authorization']

    unless @current_user = AuthenticationToken.where(['token = ? AND expires_at > ?', token, Time.now]).first.try(:user)
      head :unauthorized
    end
  end

  def current_user
    @current_user
  end
end