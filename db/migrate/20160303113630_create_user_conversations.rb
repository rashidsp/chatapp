class CreateUserConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :user_conversations do |t|
      t.references :user, foreign_key: true
      t.references :conversation, foreign_key: true
      t.integer :user_status

      t.timestamps
    end

    add_index(:user_conversations, [ :user_id, :conversation_id ])
  end
end
