class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :title
      t.integer :started_id

      t.timestamps
    end
    add_index(:conversations, [ :title, :started_id])
  end
end
