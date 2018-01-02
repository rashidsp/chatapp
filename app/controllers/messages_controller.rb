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
      send_message_notification
    else
      render json: {success: false, message: @message.errors.full_messages.to_sentence}
    end
  end

  private

  def send_message_notification
    ActionCable.server.broadcast 'messages',
      message: @message.as_json,
      sender: @message.sender.as_json
    head :ok
  end


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
