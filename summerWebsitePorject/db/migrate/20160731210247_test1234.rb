class Test1234 < ActiveRecord::Migration
  def change
  	remove_column :users, :teacher_id
  	remove_column :users, :school_class_id
  end
end
