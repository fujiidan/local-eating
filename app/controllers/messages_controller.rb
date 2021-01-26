class MessagesController < ApplicationController

  def index
    @community = Community.find(params[:community_id])
    @message = Message.new
    @messages = @community.messages.includes(:user).order("created_at DESC")
  end
  
  def create
    @community = Community.find(params[:community_id])
    @message = @community.messages.new(message_params)
    respond_to do |format|
      if @message.save
        format.js
      else 
        @messages = @community.messages.includes(:user).order("created_at DESC")
        format.html { render template: 'messages/index.html.erb' }
      end
    end    
  end
  
  private

  def message_params
    params.require(:message).permit(:message, message_images: []).merge(user_id: current_user.id)
  end  
end
