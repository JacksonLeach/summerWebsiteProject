class QsetController < ApplicationController
	helper_method :return_question
	helper_method :score_to_percent
	helper_method :find_in_2d_array
	before_action :require_teacher
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
		@question_list = current_user.questions
	end
	def return_question(id)
		@this_question = Question.find(id)
	end
	def score_to_percent(score)
		return (score * 100).to_i
	end
	def find_in_2d_array(array, val)
		return array.index{|i| i[0] == val}
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
					date = Array.new
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
		barResults = Array.new
		@results.each do |result|
			addToBarResult = []
			if result.created_at.to_date > Time.now.to_date - 1.month
				if find_in_2d_array(barResults,score_to_percent(result.score).round(10)) != nil && barResults.count > 0
					barResults[find_in_2d_array(barResults, score_to_percent(result.score))][1] += 1
				else
					addToBarResult.push(score_to_percent(result.score).round(10), 1)
				end
			end
			if addToBarResult.count > 0
				barResults.push(addToBarResult)
			end
		end
		gon.spreadData = barResults
		resultsByTag = Array.new
		current_tag = ""
		tagGroup = Array.new
		gon.tagData = Array.new

		@results.each do |result|
			MyLog.debug result
			result.question_results.each do |qr|
				MyLog.debug qr
				MyLog.debug current_tag
				MyLog.debug qr.tag
				if qr.tag == current_tag
					tagGroup.push(qr)
				else
					if tagGroup.count > 0
						MyLog.debug tagGroup
						resultsByTag.push(tagGroup)
						tagGroup = Array.new
					else
						tagGroup.push(qr)
					end
					current_tag = qr.tag
				end
			end
		end
		resultsByTag.push(tagGroup)
		MyLog.debug resultsByTag
		gon.tickData = Array.new
		index = 0
		resultsByTag.each do |tag_group|
			#MyLog.debug tag_group
			total = 0
			number = 0
			tag_group.each do |i|
				total += i.correct? ? 1 : 0
				number += 1
			end
			average = score_to_percent(total.to_f/number)
			gon.tagData.push([index, average])
			gon.tickData.push([index, tag_group[0].tag])
			index += 1
			
		end
		MyLog.debug gon.tagData
	end
	def edit
		@qset = Qset.find(params[:id])
		@question_list = current_user.questions
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
