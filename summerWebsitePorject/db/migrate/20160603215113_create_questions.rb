class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
    	t.string :question_text
    	t.string :answer
    	t.int :answer_type
    	#Distractors
    	t.string :dist1
    	t.string :dist2
    	t.string :dist3
    	t.string :tag
      t.timestamps null: false
    end
  end
end
