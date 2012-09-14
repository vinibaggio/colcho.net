class AddUserIdToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :user_id, :integer
    add_index :rooms, :user_id
  end
end
