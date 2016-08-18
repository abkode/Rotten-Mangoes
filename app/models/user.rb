class User < ApplicationRecord
	has_many :reviews, :dependent => :delete_all
	has_secure_password

	def full_name
        "#{firstname} #{lastname}"
    end

end
