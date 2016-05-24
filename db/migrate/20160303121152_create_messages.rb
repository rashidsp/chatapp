class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversation, foreign_key: true
      t.integer :type
      t.integer :sender_id

      t.timestamps
    end
    add_index(:messages, [ :conversation_id, :sender_id ])
  end
end
