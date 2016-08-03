class Test1234231 < ActiveRecord::Migration
  def change
  	#remove_column :users, :teacher_id
  	add_column :users, :teacher, :integer
  end
end
