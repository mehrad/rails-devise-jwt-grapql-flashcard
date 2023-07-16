# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  rolify
  include Gql::Interface
  before_save :create_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :token_authenticatable

  has_many :boxes, dependent: :destroy

  def admin?
    has_role? :admin
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[first_name last_name phone email]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[boxes roles]
  end

  private

  def generate_jwt
    Base64.encode64(email)
  end

  def create_token
    return if authentication_token.present?

    token = generate_jwt
    user = User.find_by(authentication_token: token)

    until user.blank?
      token = generate_jwt
      user = User.find_by(authentication_token: token)
    end
    self.authentication_token = token
  end
end
