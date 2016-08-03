class Test123423134 < ActiveRecord::Migration
  def change
  	remove_column :users, :teacher
  	remove_column :school_classes, :teacher_id
  	add_column :school_classes, :teacher, :integer
  end
end
