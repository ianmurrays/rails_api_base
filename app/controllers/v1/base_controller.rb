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

  # Public: Send errors to the clients.
  #
  # code  - Internal code for the error, useful if you want to obscure errors for security
  # error - A description of what happened
  # data  - Further data you might want to send to the client
  # 
  def send_error(code, status = :bad_request, error = nil, data = nil)
    error_hash = {
      code: code
    }

    error_hash[:message] = error if error
    error_hash[:data]    = data if data

    render json: error_hash, status: status
  end

  def current_user
    @current_user
  end
end