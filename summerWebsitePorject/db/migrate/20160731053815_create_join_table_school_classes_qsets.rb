class CreateJoinTableSchoolClassesQsets < ActiveRecord::Migration
  def change
    create_join_table :school_classes, :qsets do |t|
       t.index [:school_class_id, :qset_id]
       t.index [:qset_id, :school_class_id]
    end
  end
end
