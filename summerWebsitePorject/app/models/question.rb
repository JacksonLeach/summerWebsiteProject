class Question < ActiveRecord::Base
	has_and_belongs_to_many :qsets
	belongs_to :user
	validates :question_text, presence: true
	validates :answer, presence: true
	validates :tag, presence: true, allow_blank: true
	validates :distractors, presence: true
	validates :dist1, presence: true, :if => lambda{ |o| o.distractors == "explicit"}
	validates :dist2, presence: true, :if => lambda{ |o| o.distractors == "explicit"}
	validates :dist3, presence: true, :if => lambda{ |o| o.distractors == "explicit"}
	if (:distractors == "explicit")
		validate :check_dist_unique
	end
	def check_dist_unique

		errors.add(:distractor1, "must be unique") if dist1 == dist2 || dist1 == dist3 || dist1 == answer
		errors.add(:distractor2, "must be unique") if dist2 == dist1 || dist2 == dist3 || dist2 == answer 
		errors.add(:distractor3, "must be unique") if dist3 == dist1 || dist3 == dist2 || dist3 == answer 
	end
	attr_accessor :user_answer

end
