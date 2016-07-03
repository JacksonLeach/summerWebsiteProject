class ForiegnKeyMigration < ActiveRecord::Migration
	def change
		add_column :question_results, :user_id, :integer
		add_column :set_results, :user_id, :integer
		add_column :set_results, :qset_id, :integer
	end
end
