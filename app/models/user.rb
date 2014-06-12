class User < ActiveRecord::Base
  # Used for authentication
  has_secure_password

  # Database relationships
  has_many :authentication_tokens

  # Validations
  validates :email, presence: true, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
  validates :password, :password_confirmation, presence: true, on: :create

  # Public: Authenticates and generates an authentication token
  # with a specific expiration date.
  #
  # password   - The password to authenticate with
  # expiration - How long in seconds the authentication token 
  #              should be valid for
  #
  # Returns the AuthenticationToken or false.
  def authenticate_for_api(password, expiration = 86_400)
    # Clear old authentication tokens now that we're here
    AuthenticationToken.delete_expired!(self)

    if authenticate(password)
      # Generate an authentication token
      AuthenticationToken.generate(self, expiration)
    else
      false
    end
  end
end
