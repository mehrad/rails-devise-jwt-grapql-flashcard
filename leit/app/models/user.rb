# frozen_string_literal: true

class User < ApplicationRecord
  include Gql::Interface
  before_save :create_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :token_authenticatable

  has_many :boxes

  private

  def generate_jwt
    Base64.encode64(email)
  end

  def create_token
    if authentication_token.blank?
      token = generate_jwt
      user = User.find_by(authentication_token: token)

      until user.blank?
        token = generate_jwt
        user = User.find_by(authentication_token: token)
      end
      self.authentication_token = token
    end
  end
end
