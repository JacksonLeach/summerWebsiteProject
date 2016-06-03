class QuestionController < ApplicationController
	def index
		@questions = Question.all
	end
	def create
		@question = Question.new(params[:question])
	end


	private

	def question_params
		params.require(:question).permit(:question_text, :answer)
	end
end
