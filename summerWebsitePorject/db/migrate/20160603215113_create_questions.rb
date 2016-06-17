class CreateQuestions < ActiveRecord::Migration
	def change
    	create_table :questions do |t|
    		t.string :question_text
	    	t.string :answer
	    	
	    	t.string :dist1
	    	t.string :dist2
	    	t.string :dist3
	    	t.string :tag
	    	t.string :distractors

	      	t.timestamps null: false
	   	end
	   	execute "create sequence questions_question_id"
	end
end
