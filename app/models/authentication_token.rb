class AuthenticationToken < ActiveRecord::Base
  belongs_to :user

  validates :token, presence: true

  class << self
    def generate(user, expiration)
      token = create(token: SecureRandom.uuid, expires_at: expiration.try(:seconds).try(:from_now))
      
      user.authentication_tokens << token

      token
    end

    def delete_expired!(user)
      delete_all(['user_id = ? AND expires_at <= ?', user.id, Time.now])
    end
  end
end
  