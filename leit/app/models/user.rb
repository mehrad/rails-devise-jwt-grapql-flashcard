
class User < ApplicationRecord
  include Gql::Interface
  before_save :create_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :token_authenticatable
  has_many :flashcards

  private
    def generate_jwt
      JWT.encode({id: id, exp: 60.days.from_now.to_i}, Rails.application.secrets.secret_key_base)
    end

    def create_token
      if self.authentication_token.blank?
        token = generate_jwt
        user = User.find_by(authentication_token: token)
        
        while !user.blank?
          token = generate_jwt
          user = User.find_by(authentication_token: token)
        end
        self.authentication_token = token
      end
    end
end
