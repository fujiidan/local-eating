class MessagesController < ApplicationController

  def index
    @community = Community.find(params[:community_id])
    @message = Message.new
    @messages = @community.messages.includes(:user).order("created_at DESC")
  end
  
  def create
  end  
end
