class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation

  # Allows the index view to have access to all current messages in the conversation
  # and also the ability to create new messages.
  def index
    @messages = @conversation.messages
    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  # Validates that any new messages have correct params and redirects
  # back to the conversation if it is.
  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      flash[:alert] = "Message could not be sent."
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
