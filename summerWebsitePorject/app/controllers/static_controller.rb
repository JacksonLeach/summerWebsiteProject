class StaticController < ApplicationController
	def welcome
	end
	def nonverified
		@user = current_user
	end
end
