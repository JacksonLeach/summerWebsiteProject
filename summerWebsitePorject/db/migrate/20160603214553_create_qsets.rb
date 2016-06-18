class CreateQsets < ActiveRecord::Migration
	def change
    	create_table :qsets do |t|
    		t.string :name
      		t.timestamps null: false
      	end
      	create_table :questions do |t|
      		t.belongs_to :qset, index: true
      	end
  	end
end
