class User < ActiveRecord::Base

	# validations
	validates :name, presence: true
	validate :phonenumber, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password, presence: true
	validates :password_confirmation, presence: true

	# associations
	has_many :meals

	# methods
	

end