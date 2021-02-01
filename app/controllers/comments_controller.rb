class CommentsController < ApplicationController
  def create
    @store = Store.find(params[:store_id])
    @comment = @store.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js
      else
        @comments = @store.comments.includes(:user, [user: :profile]).with_attached_comment_images.order('created_at DESC')
        format.html { render template: 'stores/show.html.erb' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, comment_images: []).merge(user_id: current_user.id)
  end
end
