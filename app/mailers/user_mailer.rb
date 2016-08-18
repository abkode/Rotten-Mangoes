class UserMailer < ApplicationMailer
	default from: 'abozar.rahimi@gmail.com'

	def notification_email(user)
		@user = user
		# @url  = 'http://example.com/login'
		mail(to: @user.email, subject: 'Your account has been removed form Rotten Mangoes.')
	end

end
