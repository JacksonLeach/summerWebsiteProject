class SetResult < ActiveRecord::Base
	belongs_to :qset
	belongs_to :user
	has_many :question_results
end
