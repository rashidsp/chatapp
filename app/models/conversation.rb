class Conversation < ApplicationRecord
	has_many :user_conversations, dependent: :destroy
  has_many :users, through: :user_conversations
  belongs_to :starter, foreign_key: :started_id, class_name: 'User'
  has_many :messages, dependent: :destroy
end
