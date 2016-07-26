class QuestionController < ApplicationController
	before_action :require_teacher
	before_action :check_verified
	def index
		@questions = Question.order(:id)
	end
	def new
		@question = Question.new
	end
	def create
		@question = Question.new(question_params)
		@question.user_id = current_user.id
		if @question.save
			redirect_to '/questions'
			flash[:notice] = "Question successfully created!"
		else
			render 'new'
		end
	end
	def show
		@question = Question.find(params[:id])
	end
	def edit
		@question = Question.find(params[:id])
	end
	def update
		@question = Question.find(params[:id])
		if @question.update_attributes(question_params)
			redirect_to :action => 'show', :id => @question.id
			flash[:notice] = "Question successfully updated!"
		else
			render 'edit'
		end
	end


	private

	def question_params
		params.require(:question).permit(:question_text, :answer, :distractors, :dist1, :dist2, :dist3, :tag, :user_id)
	end
end
