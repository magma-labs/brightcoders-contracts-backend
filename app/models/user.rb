class User < ApplicationRecord
  devise  :rememberable, :trackable, :omniauthable, omniauth_providers: [:google_oauth2]  

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])

    user
  end 
end
