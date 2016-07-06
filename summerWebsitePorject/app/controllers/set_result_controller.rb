class SetResultController < ApplicationController
	def new 
		@set_result = SetResult.new
		@qset = Qset.find(params[:qset_id])
		@question_list = @qset.questions
	end
	def calculate_results
		@answers = params['question_data']
		correct = 0
		total = 0
		@answers.each do |a|
			question = Question.find(a[0].to_i)
			if a[1]["'user_answer'"] == question.answer
				total += 1
				correct += 1
			else
				total += 1
			end
			current_user.question_results.create(question: question.question_text, correct_answer: question.answer, user_answer: a[1]["'user_answer'"], correct?: a[1]["'user_answer'"] == question.answer, tag: question.tag, set_result_id: params[:qset_id])
		end
		flash[:notice] = correct
		current_user.set_results.create(number_of_questions: total, questions_correct: correct, score: correct.to_f/total, qset_id: params[:qset_id])

	end
	

	private
	def set_result_params
		params.require(:set_result).permit(:number_of_questions, :questions_correct, :score)
	end
end
