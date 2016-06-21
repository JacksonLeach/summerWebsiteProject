class Question < ActiveRecord::Base
	has_and_belongs_to_many :qsets
	validates :question_text, presence: true
	validates :answer, presence: true
	validates :tag, presence: true
	validates :distractors, presence: true
	validates :dist1, presence: true, :if => lambda{ |o| o.distractors == "explicit"}
	validates :dist2, presence: true, :if => lambda{ |o| o.distractors == "explicit"}
	validates :dist3, presence: true, :if => lambda{ |o| o.distractors == "explicit"}

end
