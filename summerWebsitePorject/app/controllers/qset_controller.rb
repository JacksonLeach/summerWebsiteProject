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
	def show
		@qset = Qset.find(params[:id])
		@questions = @qset.questions
	end
	def edit
		@qset = Qset.find(params[:id])
		@question_list = @qset.questions
	end
	def update
		@qset = Qset.find(params[:id])
		if @qset.update_attributes(qset_params)
			redirect_to :action => 'show', :id => @qset.id
			flash[:notice] = "Set successfully updated!"
		else
			render 'edit'
		end
	end
	private

	def qset_params
		params.require(:qset).permit(:name, :question_ids => [])
	end
end
