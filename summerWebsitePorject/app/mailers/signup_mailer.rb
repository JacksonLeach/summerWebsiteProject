class SignupMailer < ApplicationMailer
	default from: "jleach@quizzy-app.com"

	def verify_account(user)
		@user = user
		mail(to: @user.email, subject: "Please veryify your account")
	end
end
