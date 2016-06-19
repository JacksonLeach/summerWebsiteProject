class QsetController < ApplicationController
	helper_method :return_question
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
	def return_question(id)
		@this_question = Question.find(id)
	end
	private

	def qset_params
		params.require(:qset).permit(:name, :question_ids => [])
	end
end
