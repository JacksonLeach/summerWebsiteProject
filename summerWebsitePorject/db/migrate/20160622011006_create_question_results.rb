class CreateQuestionResults < ActiveRecord::Migration
  	def change
    	create_table :question_results do |t|
    		t.string :question
    		t.string :correct_answer
    		t.string :user_answer
    		t.boolean :correct?
    		t.string :tag
      		t.timestamps null: false
    	end
  	end
end
