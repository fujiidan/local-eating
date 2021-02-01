class MessagesController < ApplicationController
  before_action :find_community

  def index
    @message = Message.new
    @messages = @community.messages.includes(:user, [user: :profile]).with_attached_message_images.order('created_at DESC')
  end

  def create
    @message = @community.messages.build(message_params)
    respond_to do |format|
      if @message.save
        format.js
      else
        @messages = @community.messages.includes(:user, [user: :profile]).with_attached_message_images.order('created_at DESC')
        format.html { render template: 'messages/index.html.erb' }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:message, message_images: []).merge(user_id: current_user.id)
  end

  def find_community
    @community = Community.find(params[:community_id])
  end
end
