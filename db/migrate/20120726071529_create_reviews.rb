class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :room
      t.integer :points

      t.timestamps
    end
    add_index :reviews, :user_id
    add_index :reviews, :room_id

    add_index :reviews, [:user_id, :room_id], :unique => true
  end
end
