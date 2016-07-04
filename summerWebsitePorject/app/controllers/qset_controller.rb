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
		@results = []
		@dataToGraph = []
		current_user.set_results.each do |r|
			if r.qset_id == params[:id].to_i
				@results.push(r)
			end
		end
		current_date = ""
		date = []
		resultsByDate = []
		@results.each do |result| 
			if result.created_at.to_date == current_date 
				date.push(result)
			else
				if date.count > 0
					resultsByDate.push(date)
					date.clear
				end
				current_date = result.created_at.to_date
				date.push(result)
			end
		end
		resultsByDate.push(date)
		resultsByDate.each do |date|
			total = 0
			thisDate = ""
			date.each do |result|
				total += (result.score * 100).to_i
				thisDate = result.created_at.to_date
			end
			average = total / date.count
			@dataToGraph.push([thisDate.to_time.to_i * 1000, average])
		end
		gon.dataToGraph = @dataToGraph

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
