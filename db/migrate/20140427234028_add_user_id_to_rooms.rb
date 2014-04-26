class AddUserIdToRooms < ActiveRecord::Migration
  def change
    add_reference :rooms, :user, index: true
  end
end
