class Message < ApplicationRecord
  belongs_to :user_conversation
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
end
