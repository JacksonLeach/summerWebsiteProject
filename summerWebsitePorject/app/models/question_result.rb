class QuestionResult < ActiveRecord::Base
	belongs_to :user
	belongs_to :set_result
end
