class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_conversation

  def index
    @messages = @conversation.messages.recent.reverse
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.sender_id = current_user.id
    if @message.save
      @message
    else
      render json: {success: false, message: @message.errors.full_messages.to_sentence}
    end
  end

  private

  def message_params
    params.require(:message).permit(:body,:conversation_id)
  end

  def find_conversation
    @conversation = Conversation.where(id: params[:conversation_id]).first
    if @conversation.present?
      @coversation
    else
      render json: {success: false, message: "Conversation not found!"}
    end
  end
end
