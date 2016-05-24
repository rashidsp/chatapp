class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'

  scope :recent,->{
    order("created_at DESC").limit(10)
  }


  # def as_json
  #   hash = super(
  #       only: [
  #           :body, :sender_id, :created_at
  #       ]
  #   )
  #   hash
  # end


end
