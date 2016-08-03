class UserVerify < ActiveRecord::Migration
  def change
  	add_column :users, :verify_code, :string
  	add_column :users, :is_verified, :boolean
  end
end
