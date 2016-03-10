class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :user_conversation, foreign_key: true
      t.integer :type
      t.integer :sender_id

      t.timestamps
    end
    add_index(:messages, [ :user_conversation_id, :type, :sender_id ])
  end
end
