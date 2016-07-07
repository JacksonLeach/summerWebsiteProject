class User < ActiveRecord::Base
	has_secure_password
	has_many :users
	has_many :questions
	has_many :qsets
	has_many :set_results
	has_many :question_results

	def student?
		self.role == "student"
	end
	def teacher?
		self.role == "teacher"
	end
	def admin?
		self.role == "admin"
	end
end
