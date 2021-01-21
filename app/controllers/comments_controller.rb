class CommentsController < ApplicationController

  def create
    @store = Store.find(params[:store_id])
    @comment = @store.comments.build(comment_params)
    if @comment.save
      render json: { post: @comment}
    else
      @comments = @store.comments.includes(:user)
      render template: "stores/show"
    end  
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment, comment_images: []).merge(user_id: current_user.id)
  end  
end
