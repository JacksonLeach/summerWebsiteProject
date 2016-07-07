class AddUserId1 < ActiveRecord::Migration
	def change
		add_column :questions, :user_id, :integer
		add_column :qsets, :user_id, :integer
	end
end
