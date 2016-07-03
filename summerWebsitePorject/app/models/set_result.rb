class SetResult < ActiveRecord::Base
	belongs_to :qset
	belongs_to :user
end
