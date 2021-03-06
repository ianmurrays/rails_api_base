class V1::AuthenticationController < V1::BaseController
  skip_before_filter :authenticate!, only: [ :authenticate ]

  def authenticate
    user_params = params.permit(:email, :password)

    @token = User.find_by_email(user_params[:email]).try(:authenticate_for_api, user_params[:password])

    send_error(-1, :bad_request, 'Invalid email or password') unless @token
  end
end
