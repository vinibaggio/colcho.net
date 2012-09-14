class AddPictureToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :picture, :string
  end
end
