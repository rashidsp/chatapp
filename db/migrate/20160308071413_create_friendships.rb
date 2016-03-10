class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.integer :friend_id
      t.boolean :is_approved, default: false

      t.timestamps
    end
    add_index(:friendships, [ :user_id, :friend_id ])
  end
end
