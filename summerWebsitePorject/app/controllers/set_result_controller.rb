class SetResultController < ApplicationController
	before_action :require_student
	before_action :check_verified
	def new 
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
		

	end
	def index
		@tests = Qset.all
	end	

	private
	def set_result_params
		params.require(:set_result).permit(:number_of_questions, :questions_correct, :score)
	end
end
