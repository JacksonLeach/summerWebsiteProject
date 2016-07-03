class Qset < ActiveRecord::Base
	has_and_belongs_to_many :questions
	validates :name, presence: true
	has_many :set_results;
end
