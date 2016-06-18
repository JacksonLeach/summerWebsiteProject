class QsetController < ApplicationController
	def index
		@qsets = Qset.all
	end
	def create
		@qset = Qset.new(qset_params)
		if @qset.save
			flash[:notice] = "Set successfully created!"
			redirect_to '/questionsets'
		else
			render 'new'
		end
	end
	def new
		@qset = Qset.new
		@question_list = Question.all
	end
	private

	def qset_params
		params.require(:qset).permit(:name)
	end
end
