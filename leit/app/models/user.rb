
class User < ApplicationRecord
	include Gql::Interface
	before_save :create_token
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :validatable, :token_authenticatable

	private
	def generate_jwt
		Base64.encode64(self.email)
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
