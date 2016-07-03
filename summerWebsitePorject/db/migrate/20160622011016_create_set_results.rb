class CreateSetResults < ActiveRecord::Migration
  	def change
    	create_table :set_results do |t|
    		t.string :number_of_questions
    		t.string :questions_correct
    		t.decimal :score
      		t.timestamps null: false
    	end
 	end
end
