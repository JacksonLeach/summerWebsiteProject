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
	   	create_table :question_result_data do |t|
	   		t.bigint :attempts
	   		t.bigint :success
	   		t.bigint :failures
	   		t.doubleprecision :average
	   	end
	end
end
