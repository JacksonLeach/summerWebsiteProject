class CreateQsets < ActiveRecord::Migration
  def change
    create_table :qsets do |t|
    	
      t.timestamps null: false
    end
  end
end
