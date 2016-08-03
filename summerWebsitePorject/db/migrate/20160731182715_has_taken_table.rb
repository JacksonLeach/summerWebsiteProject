class HasTakenTable < ActiveRecord::Migration
  def change
  	create_table :has_taken_qset, :id => false do |t|
  		t.integer :qset_id, :null => false
  		t.integer :user_id, :null => false
  	end
  end
end
