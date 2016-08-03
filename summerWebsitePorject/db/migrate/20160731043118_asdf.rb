class Asdf < ActiveRecord::Migration
  def change
  	create_table :school_classes do |t|
  		t.string :name
  		t.timestamps :null => false
  	  end
  end
end
