class AddColumnsTouser < ActiveRecord::Migration
  def change
    #add_column :users, :user_id, :stirng
    add_column :users, :username, :string
    add_column :users, :about, :text
  end
end
