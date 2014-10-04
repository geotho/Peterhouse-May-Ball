class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:raven]

  def self.from_omniauth(auth_hash)
    data = auth_hash.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(name: data["name"], email: data["email"],
            password: Devise.friendly_token[0,20])
    end
    user
  end
end
