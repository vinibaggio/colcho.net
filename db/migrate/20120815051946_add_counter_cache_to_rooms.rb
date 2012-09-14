class AddCounterCacheToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :reviews_count, :integer
  end
end
