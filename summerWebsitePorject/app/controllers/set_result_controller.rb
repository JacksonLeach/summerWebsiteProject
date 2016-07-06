class SetResultController < ApplicationController
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

		@questions.each do |q|
			if q.answer == @answers["#{q.id}"]["'user_answer'"]
				total += 1
				correct += 1
			else
				total += 1
			end
			current_user.question_results.create(question: q.question_text, correct_answer: q.answer, user_answer: @answers["#{q.id}"]["'user_answer'"], correct?: q.answer == @answers["#{q.id}"]["'user_answer'"], tag: q.tag, set_result_id: params[:qset_id])
		end
		current_user.set_results.create(number_of_questions: total, questions_correct: correct, score: correct.to_f/total, qset_id: params[:qset_id])

	end
	def index
		@tests = Qset.all
	end	

	private
	def set_result_params
		params.require(:set_result).permit(:number_of_questions, :questions_correct, :score)
	end
end
