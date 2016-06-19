class CreateJoinTableQsetQuestion < ActiveRecord::Migration
  def change
    create_join_table :qsets, :questions do |t|
      # t.index [:qset_id, :question_id]
      # t.index [:question_id, :qset_id]
    end
  end
end
