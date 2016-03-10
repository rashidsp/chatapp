class ConversationsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
  	@conversations = current_user.conversations
  	@pending_conversations = User.with_pending_conversations(current_user)
  end
end
