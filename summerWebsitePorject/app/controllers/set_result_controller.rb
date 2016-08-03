class SetResultController < ApplicationController
	before_action :require_student
	before_action :check_verified
	def new 
		params[:page_header] = "Take test"
		@set_result = SetResult.new
		@qset = Qset.find(params[:qset_id])
		@question_list = @qset.questions
	end
	def calculate_results
		@qset = Qset.find(params[:qset_id])
		@answers = params['question_data']
		@questions = @qset.questions
		correct = 0
		total = 0
		newQIds = Array.new

		@questions.each do |q|
			if q.answer == @answers["#{q.id}"]["'user_answer'"]
				total += 1
				correct += 1
			else
				total += 1
			end
			new_question_result = current_user.question_results.create(question: q.question_text, correct_answer: q.answer, user_answer: @answers["#{q.id}"]["'user_answer'"], correct?: q.answer == @answers["#{q.id}"]["'user_answer'"], tag: q.tag, set_result_id: 0)
			MyLog.debug new_question_result
			newQIds.push(new_question_result.id)
			
		end
		MyLog.debug newQIds
		@new_result = current_user.set_results.create(number_of_questions: total, questions_correct: correct, score: correct.to_f/total, qset_id: params[:qset_id])
		newQIds.each do |q|
			qr = QuestionResult.find(q)
			MyLog.debug qr
			qr.set_result_id = @new_result.id
			qr.save
			MyLog.debug qr
		end
		sql = "insert into has_taken_qset (qset_id, user_id) values (" + @qset.id.to_s + ", " + current_user.id + ");"
		result = ActiveRecord::Base.connection.execute(sql)

		

	end
	def index
		params[:page_header] = "Tests availible"
		@tests = []
		current_user.school_class.each do |c|
			temp_array = Array.new
			temp_array << c.name
			c.qsets.each do |q|
				temp_array << q
				@tests << temp_array
			end
		end
	end	

	private
	def set_result_params
		params.require(:set_result).permit(:number_of_questions, :questions_correct, :score)
	end
end
