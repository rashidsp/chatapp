class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  	:recoverable, :rememberable, :trackable, :validatable


  has_many :user_conversations
  has_many :conversations, through: :user_conversations, dependent: :destroy
  has_many :created_conversations, class_name: 'Conversation', foreign_key: 'started_id'
  has_many :friendships
  has_many :friends, through: :friendships

  mount_uploader :attachment, ImageUploader

  scope :with_pending_conversations, ->(user){
  }

  scope :except_user, -> (user){
  	where.not(id: user.id)
  }

  scope :search_users, ->(key){
    where('first_name || last_name like ?',"%#{key}%")
  }

  scope :accepted_friends, -> {
    includes(:friendships).where(friendships: {is_approved: true})
  }

  scope :pending_friends, -> {
    includes(:friendships).where(friendships: {is_approved: false})
  }

  def name
    "#{first_name}" +" "+ "#{last_name}"
  end

  def is_friend?(user)
    friends.accepted_friends.include?(user)
  end

  def request_pending?(user)
    friends.pending_friends.include?(user)
  end

end
